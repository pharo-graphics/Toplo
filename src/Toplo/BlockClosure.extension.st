Extension { #name : #BlockClosure }

{ #category : #'*Toplo' }
BlockClosure >> asStateUpdater [

	^ ToStateUpdater new
		  applyWith: self;
		  yourself
]

{ #category : #'*Toplo' }
BlockClosure >> asToDataToElementConverter [

	^ ToActionDataToElementConverter new valuable: self
]
