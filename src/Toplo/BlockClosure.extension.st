Extension { #name : 'BlockClosure' }

{ #category : '*Toplo' }
BlockClosure >> asActionSelector [

	^ ToActionSelector new action: self
]
