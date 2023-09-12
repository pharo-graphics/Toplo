Extension { #name : #BlockClosure }

{ #category : #'*Toplo-Theme' }
BlockClosure >> asElementSubscription [

	^ ToElementSubscription new
		  valuable: self;
		  yourself
]
