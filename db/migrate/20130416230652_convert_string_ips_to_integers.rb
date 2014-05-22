class ConvertStringIpsToIntegers < ActiveRecord::Migration
  def up
    add_column :users, :current_sign_in_ip_int, :integer
    add_column :users, :last_sign_in_ip_int, :integer

    User.reset_column_information
    User.all.each do |r|
      r.current_sign_in_ip_int = convert_ip_to_int(r.current_sign_in_ip)
      r.last_sign_in_ip_int = convert_ip_to_int(r.last_sign_in_ip)
      r.save!
    end

    remove_column :users, :current_sign_in_ip
    remove_column :users, :last_sign_in_ip
    rename_column :users, :current_sign_in_ip_int, :current_sign_in_ip
    rename_column :users, :last_sign_in_ip_int, :last_sign_in_ip
  end

  def down
    add_column :users, :current_sign_in_ip_str, :integer
    add_column :users, :last_sign_in_ip_str, :integer

    User.reset_column_information
    User.all.each do |r|
      r.current_sign_in_ip_str = convert_ip_to_str(r.current_sign_in_ip)
      r.last_sign_in_ip_str = convert_ip_to_str(r.last_sign_in_ip)
      r.save!
    end

    remove_column :users, :current_sign_in_ip
    remove_column :users, :last_sign_in_ip
    rename_column :users, :current_sign_in_ip_str, :current_sign_in_ip
    rename_column :users, :last_sign_in_ip_str, :last_sign_in_ip
  end

private

  def self.convert_ip_to_int(value)
    # here goes code to properly convert string ip to integer
    quads = value.split('.')
    if quads.length == 4
      as_int = (quads[0].to_i * (2**24)) + (quads[1].to_i * (2**16)) + (quads[2].to_i * (2**8)) + quads[3].to_i
      as_int -= 4_294_967_296 if as_int > 2147483647 # Convert to 2's complement
    else
      as_int = nil
    end
  end

  def self.convert_ip_to_str(value)
    # here goes code to properly convert integer ip to string
    return nil unless value
    ip += 4_294_967_296 if ip < 0 # Convert from 2's complement
    "#{(ip & 0xFF000000) >> 24}.#{(ip & 0x00FF0000) >> 16}.#{(ip & 0x0000FF00) >> 8}.#{ip & 0x000000FF}"
  end

end
