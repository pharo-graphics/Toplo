Trait {
	#name : #TToListNode,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #'t - list node' }
TToListNode >> clickEventHandlerClasses [

	self explicitRequirement 
]

{ #category : #'t - list node' }
TToListNode >> flagAsDisabled: aBoolean [

	self holder disabled: aBoolean.
	super flagAsDisabled: aBoolean
]

{ #category : #'t - list node' }
TToListNode >> listElementDo: aValuable [

	self holder listElement ifNotNil: [ :le | aValuable value: le ]
]
