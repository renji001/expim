require 'roo'
require 'barby'
require 'barby/barcode/code_128'
require 'barby/outputter/html_outputter'
require 'rest-client'
require 'savon'
class PatchsController < ApplicationController
  def index
    @patchs = Patch.all
  end
  # 同步图片
  def syn_pic
    orders = Order.where(:trans_no => params[:trans])
    p orders
    orders.each do |order|
      id = order.declarer_id
      if IdPic.find_by(:url => id + '.jpg').present?
        p id + '--------------------'
        order.update(:id_pic => id + '.jpg')
      elsif IdPic.find_by(:url => id + '.png').present?
        order.update(:id_pic => id + '.png')
      end
      waybill = order.waybill
      p waybill
      if InvoicePic.find_by(:url => waybill + '.jpg').present?
        order.update(:inv_pic => waybill + '.jpg')
        p waybill + '=================='
      elsif InvoicePic.find_by(:url => waybill + '.png').present?
        order.update(:inv_pic => waybill + '.png')
      end
    end
    redirect_to :action => :index
  end


  # 图片上传
  def img_upload
    imgs_params[:imgs].each do |img|
      IdPic.new(url:img).save!
    end

    redirect_to :action => :index
  end

  def invoice_img_upload
    imgs_params[:imgs].each do |img|
      InvoicePic.new(url:img).save!
    end
    redirect_to :action => :index
  end

  # 海关放行清单
  def ciq_release
    @lists = []
    @total_package = 0
    @total_weight = 0
    orders = Order.where('trans_no = ?', params[:trans])
    orders.each do |order|
      @total_package += order.package_count.present?  ? 1 : 0
      @total_weight += order.goods_weight
    end
    waybill_nos = orders.select(:waybill).distinct
    waybill_nos.each do |waybill_no|
      @lists << orders.where('waybill = ?', waybill_no.waybill.to_s)
    end
  end

  #身份证打印
  def print_id
    @lists = []
    orders = Order.where('trans_no = ?', params[:trans])
    waybill_nos = orders.select(:waybill).distinct
    waybill_nos.each do |waybill_no|
      @lists << orders.where('waybill = ?', waybill_no.waybill.to_s)
    end
  end

  #小票打印
  def print_inv
    @lists = []
    orders = Order.where('trans_no = ?', params[:trans])
    waybill_nos = orders.select(:waybill).distinct
    waybill_nos.each do |waybill_no|
      @lists << orders.where('waybill = ?', waybill_no.waybill.to_s)
    end
    p '========'
  end


  # 商检导入表
  def ciq_in_excel
    @lists = []
    orders = Order.where('trans_no = ?', params[:trans])
    waybill_nos = orders.select(:waybill).distinct
    waybill_nos.each do |waybill_no|
      @lists << orders.where('waybill = ?', waybill_no.waybill.to_s)
    end
  end
  # 获取国内运单号
  def get_real_waybill
    lists = []
    orders = Order.where('trans_no = ?', params[:trans])
    waybill_nos = orders.select(:waybill).distinct
    waybill_nos.each do |waybill_no|
      lists << orders.where('waybill = ?', waybill_no.waybill.to_s)
    end
    # 新建webservice client
    client = Savon.client do
      wsdl  'http://192.168.1.101:8080/OMS/logis.service?wsdl	'
    end
    if lists[0][0].real_transformer == '百世汇通'
      lists.each do |list|
        locals = {
            componyCode:'EC000000',
            vericode:'test',
            in2:{
                orderHeads:{
                    cbeCode:'EC000000',
                    orderNo:list[0].waybill,
                    shipper:list[0].shipper_name,
                    shipperTelephone:list[0].real_id,
                    shipperAddress:list[0].real_addr,
                    consignee:list[0].realName,
                    consigneeTelephone:list[0].realPhone,
                    consigneeAddress:list[0].consigneeAdress,
                    consigneeProv:list[0].consigneeProv,
                    consigneeCity:list[0].consigneeCity,
                    consigneeCountry:list[0].consigneeTown
                },
                logistics:{},
                orderListss:[{goodsName:list[0].good_name}]
            }
        }
        begin
          @response = client.call(:create_bai_shi_logis, message: locals.to_h)
          if @response.to_s.length > 350
            @response = /<ns1:out>.*<\/ns1:out>/.match(@response.to_s).to_s.force_encoding('utf-8')
            @response = @response.gsub!(/<ns1:out>|<\/ns1:out>/,'').split(':')
            @real_waybill = @response[0]
            @markDest = @response[1].split('$')[0]
            @sortingCode = @response[1].split('$')[1]
            @sortingSite = @response[1].split('$')[2]

            list.update(:markDest => @markDest, :real_waybill => @real_waybill, :sortingSite => @sortingSite, :sortingCode => @sortingCode)
          end
        rescue => error
          p error
        end
      end
    else
      # 圆通面单获取


    end
    redirect_to :action => :index
  end

  # 百世面单打印
  def bs_print
    @lists = []
    @barcodeArr = []
    orders = Order.where('trans_no = ?', params[:trans])
    waybill_nos = orders.select(:waybill).distinct
    waybill_nos.each do |waybill_no|
      @lists << orders.where('waybill = ?', waybill_no.waybill.to_s)
    end
    @lists.each do |list|
      p list[0].real_waybill
      barcode = Barby::Code128C.new(list[0].real_waybill.to_s)
      @barcodeArr << barcode.to_html.html_safe
    end

  end

  def yt_print

  end

  # 商检C类报检单打印
  def ciq_c_print
    @lists = []
    @barcodeArr = []
    orders = Order.where('trans_no = ?', params[:trans])
    waybill_nos = orders.select(:waybill).distinct
    waybill_nos.each do |waybill_no|
      barcode = Barby::Code128.new(waybill_no.waybill.to_s)
      @barcodeArr << barcode.to_html.html_safe
      @lists << orders.where('waybill = ?', waybill_no.waybill.to_s)
    end
  end
  #商检入境申报单打印
  def ciq_in_print
    @lists = []
    orders = Order.where('trans_no = ?', params[:trans])
    waybill_nos = orders.select(:waybill).distinct
    waybill_nos.each do |waybill_no|
      @lists << orders.where('waybill = ?', waybill_no.waybill.to_s)
    end
  end

  # 宇迅面单打印
  def yx_print
    @lists = []
    @barcodeArr = []
    orders = Order.where('trans_no = ?', params[:trans])
    waybill_nos = orders.select(:waybill).distinct
    waybill_nos.each do |waybill_no|
      barcode = Barby::Code128.new(waybill_no.waybill.to_s)
      @barcodeArr << barcode.to_html.html_safe
      @lists << orders.where('waybill = ?', waybill_no.waybill.to_s)
    end
  end

  def load_excel
    upload_io = params[:excel]
    book = Roo::Spreadsheet.open(upload_io, extension: :xlsx)
    sheet = book.sheet(0)
    if Patch.find_by(trans_no: sheet.row(2)[0]).present?
      redirect_to action: :index
    else
      @patch = Patch.new
      @patch.orders_count = 0
      @patch.trans_no = sheet.row(2)[0]
      @patch.total_weight = 0
      @patch.package_count = 0
      @patch.goods_count = 0
      @patch.import_time = Time.now
      @patch.patch_no = sheet.row(2)[63]

      # @orderlist = @order.orderlists.new
      sheet.each_with_index do |row, key|
        if key > 0
          @patch.total_weight += row[52]
          @patch.goods_count += row[46]
          @patch.package_count += row[20].to_i

          @order = @patch.orders.new
          @order.trans_no = row[0]
          @order.waybill = row[1]
          @order.local_port = row[3]
          @order.in_out_time = row[4]
          @order.ship_port = row[5]
          @order.conveyance_name = row[6]
          @order.conveyance_code = row[7]
          @order.conveyance_type = row[8]
          @order.declarer_name = row[28]
          @order.declare_company_code = row[16]
          @order.declare_company_name = row[17]
          @order.trade_country = row[19]
          @order.package_count = row[20]
          @order.package_type = row[21]
          @order.declare_port = row[23]
          @order.shipper_name = row[25]
          @order.real_id = row[26]   # 发件人电话
          @order.real_addr = row[27]  # 发件人地址
          @order.shipper_country = row[29]
          @order.shipper_city = row[30]
          @order.declarer_id = row[32]
          @order.currency = row[33]
          @order.main_good = row[35]

          @order.good_serial_num = row[37]
          @order.good_no = row[38]
          @order.good_name = row[39]
          @order.good_type = row[40]
          @order.declare_price = row[43]
          @order.declare_total = row[44]
          @order.declare_num = row[46]
          @order.declare_unit = row[47]
          @order.goods_weight = row[52]

          @order.declarer_phone = row[54]
          @order.declarer_addr = row[55]
          @order.real_transformer = row[56]
          @order.realName = row[57]
          @order.realPhone = row[58]
          @order.consigneeProv = row[59]
          @order.consigneeCity = row[60]
          @order.consigneeTown = row[61]
          @order.consigneeAdress = row[62]
          @order.save

        end
      end
      @patch.save
      redirect_to :action => :index
    end
  end

  private
  def imgs_params
    params.permit({imgs:[]})
  end
end
