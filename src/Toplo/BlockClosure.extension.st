Extension { #name : #BlockClosure }

{ #category : #'*Toplo' }
BlockClosure >> asStateUpdater [

	^ ToStateUpdaterDep new
		  applyWith: self;
		  yourself
]

{ #category : #'*Toplo' }
BlockClosure >> asToDataToElementConverter [

	^ ToActionDataToElementConverter new valuable: self
]
