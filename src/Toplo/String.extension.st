Extension { #name : #String }

{ #category : #'*Toplo' }
String >> asElementSelector [ 

	^ ToStampSelector new addStampName: self asSymbol
]

{ #category : #'*Toplo' }
String >> asStyleStamp [

	^ ToStyleStamp new
		  name: self asSymbol;
		  value: true;
		  yourself
]
