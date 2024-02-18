{#
    This macro returns the description of the payment_type 
#}

{% macro get_payment_type_description(payment_type) -%}

    case cast( {{ payment_type }} as numeric)
        when 1.0 then 'Credit card'
        when 2.0 then 'Cash'
        when 3.0 then 'No charge'
        when 4.0 then 'Dispute'
        when 5.0 then 'Unknown'
        when 6.0 then 'Voided trip'
        else 'EMPTY'
    end

{%- endmacro %}