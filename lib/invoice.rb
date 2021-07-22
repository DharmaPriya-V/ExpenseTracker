module Invoice
    def invoice_check(detail)
        employee=User.find(detail.user_id)
        uri = URI.parse("https://my.api.mockaroo.com/invoices.json")
        request = Net::HTTP::Post.new(uri)
        request["X-Api-Key"] = "b490bb80"
        request.body = JSON.dump({
        "invoice_id" => detail.invoiceno
        })
        req_options = {
        use_ssl: uri.scheme == "https",
        }
        response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
        end
        output = response.body
        check = JSON.parse output.gsub('=>', ':')
        if check['status'] == false
            detail.rejected!
            ApprovalMailer.with(updater: employee, det: detail).confirmation.deliver_now
        else
            detail.update(system_check_status: true)
        end
    end
end    