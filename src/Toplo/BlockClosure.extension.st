Extension { #name : #BlockClosure }

{ #category : #'*Toplo' }
BlockClosure >> asElementAdapter [

	^ ToElementAdapter new
		  valuable: self;
		  yourself
]

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
