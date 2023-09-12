Extension { #name : #BlockClosure }

{ #category : #'*Toplo-Theme' }
BlockClosure >> asElementUpdater [

	^ ToElementUpdater new
		  valuable: self;
		  yourself
]
