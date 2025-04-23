Trait {
	#name : #TToListInnerElement,
	#category : #'Toplo-Widget-List-Core-BarElement'
}

{ #category : #'t - list node holder' }
TToListInnerElement >> disableScrolledEvent [

	self eventDispatcher disableScrolledEvent 
]

{ #category : #'t - list node holder' }
TToListInnerElement >> enableScrolledEvent [

	self eventDispatcher enableScrolledEvent
]

{ #category : #'t - list node holder' }
TToListInnerElement >> findElementHolderForDataSourcePosition: aPosition [

	self explicitRequirement 
]

{ #category : #'t - list node holder' }
TToListInnerElement >> nodeAt: anIndex [

	" return the holder for the data at anIndex according to currently viewed data range. 
	Returns nil if anIndex is not currently viewed in the infinite element"
	^ (self findElementHolderForDataSourcePosition: anIndex)
		  ifNotNil: [ :holder | holder itemElement ]
		  ifNil: [  ]
]

{ #category : #'t - list node holder' }
TToListInnerElement >> nodeGroupsSatisfying: aBlock [
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
TToListInnerElement >> nodes [

	^ self explicitRequirement 
]

{ #category : #'t - list node holder' }
TToListInnerElement >> nodesDo: aBlock [

	^ self explicitRequirement 
]

{ #category : #'t - list node holder' }
TToListInnerElement >> nodesSelect: aBlock [

	^ self explicitRequirement 
]

{ #category : #'t - list node holder' }
TToListInnerElement >> nodesWithIndexDo: aBlock [

	^ self explicitRequirement 
]

{ #category : #'t - list node holder' }
TToListInnerElement >> notifyChildAttached: anElement [
	"Notify all event handlers that element (a node) is attached "

	self dispatchEvent: (BlInfiniteElementAttachedEvent element: anElement)
]

{ #category : #'t - list node holder' }
TToListInnerElement >> notifyChildDetached: anElement [
	"Notify all event handlers that element ( a node) is detached "

	self dispatchEvent: (BlInfiniteElementDetachedEvent element: anElement)
]

{ #category : #'t - list node holder' }
TToListInnerElement >> partlyVisibleNodesDo: aBlock [

	^ self explicitRequirement 
]

{ #category : #'t - list node holder' }
TToListInnerElement >> partlyVisibleNodesSelect: aBlock [

	^ self explicitRequirement 
]

{ #category : #'t - list node holder' }
TToListInnerElement >> selectableNodeContainingGlobalPosition: aPoint [

	self nodesDo: [ :node |
		((node containsGlobalPoint: aPoint) and: [ node holder isSelectable ])
			ifTrue: [ ^ node ] ].
	^ nil
]
