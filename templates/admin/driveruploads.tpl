{literal}
<script type="text/javascript">
  $(function(){
    var total = {/literal}{$datatotal}{literal};
    var sections = {/literal}{$sectiontotal}{literal}
    if (sections <= 1 ){
      $(".pagernav").css('display','none');
    }
    $('#dgroup1').css('display','block');
    $('.prev').hover(
      function () {
        $(this).css("color","#ffffff");
        $(this).css("cursor","pointer");
       },
       function () {
        $(this).css("color","#3a82a3");
      });
      
    $('.next').hover(
      function () {
        $(this).css("color","#ffffff");
        $(this).css("cursor","pointer");
       },
       function () {
        $(this).css("color","#3a82a3");
      });
    
    $('.prev').click(function() {
      var dir = $(this).attr('class');
      pager(dir);
    });
    $('.next').click(function() {
      var dir = $(this).attr('class');
      pager(dir);
    });
    
    function pager(dir){
      var thediv,delta;
      
      //determine direction of pager
      if (dir == "prev"){
        delta = -1;
      }
      else
      {
        delta =1;
      }
      
      //find current visible page
      for (var i=1; i<= sections; i++)
      {
        thediv = "dgroup"+i;
        
        if($('#'+thediv).css('display') == "block")
        {
          if(i == 1 && delta == -1){return;}
          if( i == sections && delta == 1){   return;}
          
          $('#'+thediv).css('display','none');
          thediv = "dgroup"+(i+delta);
          $('#'+thediv).css('display','block');
          $('.seccount').html(i+delta);
          return;
        }
      }
    }
    
  });

</script>
{/literal}

<div class="pagernav" style="position: relative; margin: 0px 0px 10px 0px;">
  <div class="buttonbox">
    <div class="prev">&lt;PREV</div>
    <div class="pagerbody">page <span class="seccount">1</span> of {$sectiontotal} pages </div>  
    <div class="next">NEXT&gt;</div>
  </div>
  <div class="totalbox"><span class="totalcount">{$datatotal}</span> drivers in queue</div>
</div>

{ section name=sec start=0 loop= $sectiontotal }
<div id ="dgroup{$smarty.section.sec.iteration}" style="display: none; margin-bottom: 20px;"> 
  <table width="100%" cellpadding="2" cellspacing="1" style="background: #ccc;">
      <tr style="background: #EEE;">
          <th>Driver Name
          </th>
          <th>Username
          </th>
      <td>Date Submitted
          </th>
      <td>Release Date
          </th>
          <th>Status
          </th>
          <th>Approver
          </th>
          <th>Status Date
          </th>
      </tr>
	
	{foreach from=$dataDrivers item=driver name=myloop}
    { if ($smarty.foreach.myloop.iteration <= $smarty.section.sec.iteration * $pagesize ) && ($smarty.foreach.myloop.iteration > ($smarty.section.sec.iteration * $pagesize)-$pagesize) }
    <tr style="background: {cycle values="#F5F5F5,#EEEEEE"}">
        <td>{$driver.name}
        </td>
        <td>{$driver.contributor}
        </td>
        <td>{$driver.submitted}
        </td>
        <td>{$driver.showentry}
        </td>
        <td>
        	{if $driver.approved != ""}
        		Approved
			{/if}	
        	{if $driver.rejected != ""}
        		Rejected
			{/if}	
        </td>
        <td>{$driver.approver}
        </td>
        <td> 
			{if $driver.approved != ""}
        		{$driver.approved}
			{/if}	
        	{if $driver.rejected != ""}
        		{$driver.rejected}
			{/if}
        </td>
    </tr>
	
	<!--<tr style="background: #F5F5F5"}">
		<td colspan="7">{$printer.comment}</td>
	</tr>//-->
  {/if}
	{/foreach}
  </table>
  </div>
{ /section }
 


</table>
