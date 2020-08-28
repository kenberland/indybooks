require 'aws-sdk-dynamodb'

class DynamodbManager
  attr_accessor :client, :table_name
  def initialize(region:, table_name:, access_key_id: nil,
                 secret_access_key: nil, profile_name: 'default', endpoint: nil)
    if access_key_id.nil? && secret_access_key.nil?
      access_key_id = ENV['AWS_ACCESS_KEY_ID']
      secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']

      credentials = Aws::SharedCredentials.new(profile_name: profile_name).credentials if access_key_id.nil? && secret_access_key.nil?
    end
    credentials = Aws::Credentials.new(access_key_id, secret_access_key)

    @table_name      = table_name

    if endpoint
      @client = Aws::DynamoDB::Client.new(
        region:      region,
        credentials: credentials,
        endpoint:    endpoint
      )
    else
      @client = Aws::DynamoDB::Client.new(
        region:      region,
        credentials: credentials,
      )
    end
  end

  def table
    create_table unless @client.list_tables.table_names.include?(@table_name)

    @client.describe_table(table_name: @table_name)
  end

  def put_offer(offer)
    @client.put_item(
      {
        table_name: @table_name,
        item: {
          'isbn'   => offer[:isbn],
          'vendor_uuid' => offer[:vendor_uuid],
          'delivery_promise' => offer[:delivery_promise],
          'ask' => offer[:ask],
        }
      }
    )
  end

  def query(isbn)
    client.query(
      {
        table_name: @table_name,
        key_condition_expression: "isbn = :isbn",
        expression_attribute_values: {
          ":isbn" => isbn
        }
      }
    )
  end

  private

  def create_table
    @client.create_table({
      key_schema: [
        { attribute_name: 'isbn',  key_type: 'HASH' },
        { attribute_name: 'vendor_uuid', key_type: 'RANGE' },
      ],
      attribute_definitions: [
        { attribute_name: 'isbn',    attribute_type: 'S' },
        { attribute_name: 'vendor_uuid',   attribute_type: 'S' },
      ],
      provisioned_throughput: {
        read_capacity_units: 10,
        write_capacity_units: 5,
      },
      table_name: @table_name
    })
  end
end
