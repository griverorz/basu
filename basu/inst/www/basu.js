function vectorize_input(x, parseFun) {
    if (x == "") {
        return null;
    }
    var res = x.split(/[ ,]+/).map(parseFun);
    return res;
}


function EH(p1, p2) {
    if (p1.length != p2.length) {
        alert("p1 and p2 have different lengths");
    }
    var output = []
    for (var i = 0; i < p1.length; i++) {
        output[i] = 2 * Math.asin(Math.sqrt(p1[i])) - 2 * Math.asin(Math.sqrt(p2[i]));
    }
    return output;
}


function build_table(x) {

    var hnames = {
        r : "Correlation coefficient",
        h : "Effect size",
        d : "Effect size",
        n : "Sample size",
        deff : "Design effect",
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


function cohen_table(x) {
    
    var hnames = {
        "test" : "Test",
        "size" : "Size",
        "effect.size" : "Effect size",
        "method" : "Method",
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
    params["p1"] = vectorize_input($("#p1").val(), parseFloat) || null;
    params["p2"] = vectorize_input($("#p2").val(), parseFloat) || null;
    params["sig.level"] = vectorize_input($("#siglevel").val(), parseFloat) || null;
    params["power"] = vectorize_input($("#power").val(), parseFloat) || null;
    params["alternative"] = $("#alternative").val();
    params["n"] = vectorize_input($("#size1").val(), parseFloat) || null;
    params["deff"] = parseFloat($("#deff").val());

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
    
    console.log(params);
    delete params['p1'];
    delete params['p2'];
    return params;
}


function t_test_param_builder() {
    var params = {};
    params["d"] = vectorize_input($("#td").val(), parseFloat) || null;
    params["sig.level"] = vectorize_input($("#tsiglevel", parseFloat).val()) || null;
    params["power"] = vectorize_input($("#tpower").val(), parseFloat) || null;
    params["n"] = vectorize_input($("#tsize").val(), parseFloat) || null;
    params["alternative"] = $("#talternative").val();
    params["type"] = $("#ttype").val();
    params["deff"] = parseFloat($("#deff").val()); 
    
    for (var key in params) {
        if (params[key] == null) {
            delete params[key];
        }
    }
    
    return params;
}



function r_test_param_builder() {
    var params = {};
    params["r"] = vectorize_input($("#rr", parseFloat).val()) || null;
    params["sig.level"] = vectorize_input($("#rsiglevel", parseFloat).val()) || null;
    params["power"] = vectorize_input($("#rpower", parseFloat).val()) || null;
    params["n"] = vectorize_input($("#rsize").val(), parseFloat) || null;
    params["alternative"] = $("#ralternative").val();
    
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
                               if (("n" in params) && (params["deff"] != 1)) {
                                   output["deff"] = "Design effect was ignored";
                               }

                               build_table(output);
                           });
        req.fail(function() {
            alert("Error: " + req.responseText);
        });
    });

    $("#ttest").click(function() {
        var params = t_test_param_builder();
        var req = ocpu.rpc("v.pwr.t.test",
                           params,
                           function(output) {
                               if (("n" in params) && (params["deff"] != 1)) {
                                   output["deff"] = "Design effect was ignored";
                               }
                               build_table(output);
                           });
        
        req.fail(function() {
            alert("Error: " + req.responseText);
        });
    });
    $("#rtest").click(function() {
        var params = r_test_param_builder();
        var req = ocpu.rpc("v.pwr.r.test",
                           params,
                           function(output) {
                               build_table(output);
                           });
        
        req.fail(function() {
            alert("Error: " + req.responseText);
        });
    });
   
    $("#cohensize").click(function() {
        var req = ocpu.rpc("cohen.ES",
                           {
                               test : $("#cohentest").val(),
                               size : $("#coheneffsize").val()
                           },
                           function(output) {
                               cohen_table(output);
                           });
        
        req.fail(function() {
            alert("Error: " + req.responseText);
        });
    });

});
