from typing import Dict

from pandas import DataFrame
from sqlalchemy.engine.base import Engine


def load(data_frames: Dict[str, DataFrame], database: Engine):
    """Load the dataframes into the sqlite database.

    Args:
        data_frames (Dict[str, DataFrame]): A dictionary with keys as the table names
        and values as the dataframes.
        database (Engine): The connection to the SQLAlchemy database.
    Raises:
        ValueError: If some dataframe is empty.
        TypeError: If some dict key is not a string or the value is not a valid dataframe.
    """

    for table_name, df in data_frames.items():

        # Validate the key type
        if not isinstance(table_name, str):
            raise TypeError(f"The name of the table must be a string, got {type(table_name)}")

        # Validate that it´s a Dataframe
        if not isinstance(df, DataFrame):
            raise TypeError(f"The associated value with the key '{table_name}' must be a DataFrame, got {type(df)}")

        # Validate that the dataframe is not empty
        if df.empty:
            raise ValueError(f"The dataframe for the table '{table_name}' is empty and cannot be inserted")

        df.to_sql(name=table_name, con=database, if_exists="replace", index=False)
