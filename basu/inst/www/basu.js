function EH(p1, p2) {
    return 2 * Math.asin(Math.sqrt(p1)) - 2 * Math.asin(Math.sqrt(p2))
}


function build_table(x) {

    var hnames = {
        h : "Effect size",
        d : "Effect size",
        n : "Sample size",
        n1 : "Sample one size",
        n2 : "Sample two size",
        "sig.level" : "Significance level",
        power : "Power",
        alternative : "Alternative hypothesis",
        method : "Method",
        note : "Notes"
    }
        
    var table = $("#basuoutput");
    table.find('tbody').empty();
        
    for (var key in x){
        var row =  $('<tr/>', {class: '' }); 
        row.append($('<td/>').append(hnames[key]));
        row.append($('<td/>').append(x[key]));
        table.find('tbody').append(row);
    }
    $('#basuoutput').addClass("table table-hover");
    $("tr:even").addClass("table-active");    
}


function p_test_param_builder() {
    var params = {};
    params["p1"] = parseFloat($("#p1").val()) || null;
    params["p2"] = parseFloat($("#p2").val()) || null;
    params["sig.level"] = parseFloat($("#siglevel").val()) || null;
    params["power"] = parseFloat($("#power").val()) || null;
    params["alternative"] = $("#alternative").val();
    params["n"] = Number($("#size1").val()) || null;
        
    for (var key in params) {
        if (params[key] == null) {
            delete params[key];
        }
    }

    if (params["p2"] == null) {
        params['h'] = params['p1'];
    } else {
        params['h'] = EH(params['p1'], params['p2']);
    }
    
    delete params['p1'];
    delete params['p2'];
    return params;
}


function t_test_param_builder() {
    var params = {};
    params["d"] = parseFloat($("#td").val()) || null;
    params["sig.level"] = parseFloat($("#tsiglevel").val()) || null;
    params["power"] = parseFloat($("#tpower").val()) || null;
    params["n"] = Number($("#tsize").val()) || null;
    params["alternative"] = $("#talternative").val();
    params["type"] = $("#ttype").val();
    
    for (var key in params) {
        if (params[key] == null) {
            delete params[key];
        }
    }
    
    return params;
}
                      


$(document).ready(function() {
    
    // var istr = '<div class="form-group">' +
    //     '<label>Second sample size</label>' +
    //     '<input class="form-control" id="size2" type="number" step="1" min="0" />' + 
    //     '</div>'

    // $(function() {
    //     $('#pfunction').on(function() {
    //         if ($(this).val() == 'pwr.2p2n.test') {
    //             $('#isize').after(istr);
    //         } else {
    //             $('#size2').remove();
    //         }
    //     });    
    // });

    $("#ptest").click(function() {
        var params = p_test_param_builder();
        var f = $("#pfunction").val();
        var req = ocpu.rpc(f,
                           params,                           
                           function(output) {
                               build_table(output);
                           });
        
        req.fail(function() {
            alert("Error: " + req.responseText);
        });
    });

    $("#ttest").click(function() {
        var params = t_test_param_builder();
        var req = ocpu.rpc("pwr.t.test",
                           params,
                           function(output) {
                               build_table(output);
                           });
        
        req.fail(function() {
            alert("Error: " + req.responseText);
        });
    });

});
