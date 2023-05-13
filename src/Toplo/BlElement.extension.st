Extension { #name : #BlElement }

{ #category : #'*Toplo' }
BlElement >> asPlaceholderLayer [

	^ ToPanePlaceholderLayer new
		  in: [ :placeholder | placeholder addChild: self ];
		  yourself
]

{ #category : #'*Toplo' }
BlElement >> holder [

	^ self constraints infinite holder
]
