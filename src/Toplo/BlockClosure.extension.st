Extension { #name : #BlockClosure }

{ #category : #'*Toplo' }
BlockClosure >> asToDataToElementConverter [

	^ ToActionDataToElementConverter new valuable: self
]
