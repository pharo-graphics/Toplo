Extension { #name : #String }

{ #category : #'*Toplo-Theme' }
String >> asStyleNamedValue [

	^ ToStyleNamedValue new
		  name: self asSymbol;
		  value: true;
		  yourself
]

{ #category : #'*Toplo-Theme' }
String >> asStyleSelector [ 

	^ ToStyleTagSelector new styleTag: self asSymbol
]
