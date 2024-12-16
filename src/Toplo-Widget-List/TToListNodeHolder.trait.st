Trait {
	#name : #TToListNodeHolder,
	#category : #'Toplo-Widget-List-Core-BarElement'
}

{ #category : #'t - list node holder' }
TToListNodeHolder >> configureLayoutIn: aBarElement [

	self explicitRequirement 
]

{ #category : #'t - list node holder' }
TToListNodeHolder >> disableScrolledEvent [

	self eventDispatcher disableScrolledEvent 
]

{ #category : #'t - list node holder' }
TToListNodeHolder >> enableScrolledEvent [

	self eventDispatcher enableScrolledEvent
]

{ #category : #'t - list node holder' }
TToListNodeHolder >> findElementHolderForDataSourcePosition: aPosition [

	self explicitRequirement 
]

{ #category : #'t - list node holder' }
TToListNodeHolder >> nodeAt: anIndex [

	" return the holder for the data at anIndex according to currently viewed data range. 
	Returns nil if anIndex is not currently viewed in the infinite element"
	^ (self findElementHolderForDataSourcePosition: anIndex)
		  ifNotNil: [ :holder | holder itemElement ]
		  ifNil: [  ]
]

{ #category : #'t - list node holder' }
TToListNodeHolder >> nodeGroupsSatisfying: aBlock [
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
TToListNodeHolder >> nodes [

	^ self explicitRequirement 
]

{ #category : #'t - list node holder' }
TToListNodeHolder >> nodesDo: aBlock [

	^ self explicitRequirement 
]

{ #category : #'t - list node holder' }
TToListNodeHolder >> nodesSelect: aBlock [

	^ self explicitRequirement 
]

{ #category : #'t - list node holder' }
TToListNodeHolder >> nodesWithIndexDo: aBlock [

	^ self explicitRequirement 
]

{ #category : #'t - list node holder' }
TToListNodeHolder >> notifyChildAttached: anElement [
	"Notify all event handlers that element (a node) is attached "

	self dispatchEvent: (BlInfiniteElementAttachedEvent element: anElement)
]

{ #category : #'t - list node holder' }
TToListNodeHolder >> notifyChildDetached: anElement [
	"Notify all event handlers that element ( a node) is detached "

	self dispatchEvent: (BlInfiniteElementDetachedEvent element: anElement)
]

{ #category : #'t - list node holder' }
TToListNodeHolder >> partlyVisibleNodesDo: aBlock [

	^ self explicitRequirement 
]

{ #category : #'t - list node holder' }
TToListNodeHolder >> partlyVisibleNodesSelect: aBlock [

	^ self explicitRequirement 
]

{ #category : #'t - list node holder' }
TToListNodeHolder >> selectableNodeContainingGlobalPosition: aPoint [

	self nodesDo: [ :node |
		((node containsGlobalPoint: aPoint) and: [ node holder isSelectable ])
			ifTrue: [ ^ node ] ].
	^ nil
]
