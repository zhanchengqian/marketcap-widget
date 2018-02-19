# Zhancheng Qian, February 2018

# Modified from Sebastian Stiernborg's cryptowidget
# Made possible with Coinmarketcap API (www.coinmarketcap.com)
command: "curl -s 'https://api.coinmarketcap.com/v1/global/'"

refreshFrequency: 5000

style: """
  bottom:60px
  left: 50px
  color: #fff
  font-family: Helvetica Neue

  table
    border-collapse: collapsec
    table-layout: fixed
    -webkit-font-smoothing: antialiased
    -moz-osx-font-smoothing: grayscale

  td
    font-size: 30px
    font-weight: 200
    width: 200px
    max-width: 400px
    overflow: hidden

  .wrapper
    padding: 5px 5px 5px 5px
    position: relative

  .label
    font-weight: normal
    font-size: 16 px
"""


render: -> """
  <table><tr><td>Loading...</td></tr></table>
"""


update: (output, domEl) ->
  try
    res = JSON.parse(output)
  catch e
    return

  data = Object.keys(res).map((k) -> res[k])
  console.log data
  table  = $(domEl).find('table')
  table.html ""

  renderCurrency = (label, price) ->
    """
    <td>
      <div class='wrapper'>
        <span class=label> #{label}</span> <br>
        #{price}
      </div>
    </td>
    """

  for value, i in data
    if i == 0
      label = 'Market Cap'
      tempPrice = ''
      testdata = "1506875689685"
      # data[0] = testdata
      strlen = data[0].toString().length
      for j in [(strlen-1)...-1] by -1
        if (strlen-(j+1))%3 == 0 && j!= strlen-1
          tempPrice = ',' + tempPrice
        tempPrice = data[0].toString().charAt(j) + tempPrice
      price = '$\xa0'+ tempPrice
      if i % 2 == 0
        table.append "<tr/>"
      table.find("tr:last").append renderCurrency(label, price)
