if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    data = data.loc[data['passenger_count'] > 0]
    data = data.loc[data['trip_distance'] > 0]
    data['lpep_pickup_date'] = data['lpep_pickup_datetime'].dt.date

    data.columns = (data.columns
                    .str.lower()
                    .str.replace('id', '_id')
                    )
                    
    return data
    
@test
def test_output(output, *args) -> None:
    assert any(output.columns.isin(['vendor_id'])) == 1, 'The column "vendor id" is not in the dataframe'
    assert output['passenger_count'].isin([0]).sum() == 0, 'There are rides with zero passengers'
    assert output['trip_distance'].isin([0]).sum() == 0, 'There are rides with zero trip distance'
