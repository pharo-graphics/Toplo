Extension { #name : #ToSelectorInterpreter }

{ #category : #'*Toplo-Theme' }
ToSelectorInterpreter >> visitStyleStampSelector: aSelector [

	result := aSelector stampNames allSatisfy: [ :t | targetStack top hasStamp: t ]
]
