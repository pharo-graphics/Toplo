Extension { #name : #String }

{ #category : #'*Toplo-Theme' }
String >> asStyleSelector [ 

	^ ToStyleStampSelector new addStampName: self asSymbol
]

{ #category : #'*Toplo-Theme' }
String >> asStyleStamp [

	^ ToStyleStamp new
		  name: self asSymbol;
		  value: true;
		  yourself
]
