# Copyright © 2023 Province of British Columbia
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
import cx_Oracle
import os

def oracle_db_dump():
    connection = None
    try:
        username = os.environ['COLIN_USER']
        password = os.environ['COLIN_PASSWORD']
        dsn = os.environ['COLIN_DSN']
        encoding = os.environ['COLIN_ENCODING']
        connection = cx_Oracle.connect(
            username,
            password,
            dsn,
            encoding=encoding)

        # show the version of the Oracle Database
        print(connection.version)
    except cx_Oracle.Error as error:
        print(error)
    finally:
        # release the connection
        if connection:
            connection.close()


if __name__ == '__main__':
    oracle_db_dump()