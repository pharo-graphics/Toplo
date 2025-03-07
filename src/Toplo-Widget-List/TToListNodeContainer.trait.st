Trait {
	#name : #TToListNodeContainer,
	#category : #'Toplo-Widget-List-Core-BarElement'
}

{ #category : #'t - list node holder' }
TToListNodeContainer >> disableScrolledEvent [

	self eventDispatcher disableScrolledEvent 
]

{ #category : #'t - list node holder' }
TToListNodeContainer >> enableScrolledEvent [

	self eventDispatcher enableScrolledEvent
]

{ #category : #'t - list node holder' }
TToListNodeContainer >> findElementHolderForDataSourcePosition: aPosition [

	self explicitRequirement 
]

{ #category : #'t - list node holder' }
TToListNodeContainer >> nodeAt: anIndex [

	" return the holder for the data at anIndex according to currently viewed data range. 
	Returns nil if anIndex is not currently viewed in the infinite element"
	^ (self findElementHolderForDataSourcePosition: anIndex)
		  ifNotNil: [ :holder | holder itemElement ]
		  ifNil: [  ]
]

{ #category : #'t - list node holder' }
TToListNodeContainer >> nodeGroupsSatisfying: aBlock [
	" return an array of collection. Each collection contains a list of adjacent selected nodes "

	^ Array streamContents: [ :stream |
		  | g |
		  g := OrderedCollection new.
		  self partlyVisibleNodesDo: [ :node |
			  (aBlock value: node)
				  ifTrue: [ g add: node ]
				  ifFalse: [
					  g ifNotEmpty: [
						  stream nextPut: g.
						  g := OrderedCollection new ] ] ].
		  g ifNotEmpty: [ stream nextPut: g ] ]
]

{ #category : #'t - list node holder' }
TToListNodeContainer >> nodes [

	^ self explicitRequirement 
]

{ #category : #'t - list node holder' }
TToListNodeContainer >> nodesDo: aBlock [

	^ self explicitRequirement 
]

{ #category : #'t - list node holder' }
TToListNodeContainer >> nodesSelect: aBlock [

	^ self explicitRequirement 
]

{ #category : #'t - list node holder' }
TToListNodeContainer >> nodesWithIndexDo: aBlock [

	^ self explicitRequirement 
]

{ #category : #'t - list node holder' }
TToListNodeContainer >> notifyChildAttached: anElement [
	"Notify all event handlers that element (a node) is attached "

	self dispatchEvent: (BlInfiniteElementAttachedEvent element: anElement)
]

{ #category : #'t - list node holder' }
TToListNodeContainer >> notifyChildDetached: anElement [
	"Notify all event handlers that element ( a node) is detached "

	self dispatchEvent: (BlInfiniteElementDetachedEvent element: anElement)
]

{ #category : #'t - list node holder' }
TToListNodeContainer >> partlyVisibleNodesDo: aBlock [

	^ self explicitRequirement 
]

{ #category : #'t - list node holder' }
TToListNodeContainer >> partlyVisibleNodesSelect: aBlock [

	^ self explicitRequirement 
]

{ #category : #'t - list node holder' }
TToListNodeContainer >> selectableNodeContainingGlobalPosition: aPoint [

	self nodesDo: [ :node |
		((node containsGlobalPoint: aPoint) and: [ node holder isSelectable ])
			ifTrue: [ ^ node ] ].
	^ nil
]
