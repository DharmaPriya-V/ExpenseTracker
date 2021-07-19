module Invoice
    def invoice_check(detail)
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
        else
            detail.update(system_check_status: true)
            #ExpenseGroupMailer.with(user: employee, title: expense_group.title, applied_amount: expense_group.applied_amount).reject_message.deliver_now
        end
    end
end    