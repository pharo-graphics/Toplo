Trait {
	#name : #TToListInnerElement,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'t - list inner element' }
TToListInnerElement >> disableScrolledEvent [

	self eventDispatcher disableScrolledEvent 
]

{ #category : #'t - list inner element' }
TToListInnerElement >> enableScrolledEvent [

	self eventDispatcher enableScrolledEvent
]

{ #category : #'t - list inner element' }
TToListInnerElement >> findElementHolderForDataSourcePosition: aPosition [

	self explicitRequirement 
]

{ #category : #'t - list inner element' }
TToListInnerElement >> nodeContainerAt: anIndex [

	" return the holder for the data at anIndex according to currently viewed data range. 
	Returns nil if anIndex is not currently viewed in the infinite element"
	^ (self findElementHolderForDataSourcePosition: anIndex)
		  ifNotNil: [ :holder | holder itemElement ]
		  ifNil: [  ]
]

{ #category : #'t - list inner element' }
TToListInnerElement >> nodeContainers [

	^ self explicitRequirement 
]

{ #category : #'t - list inner element' }
TToListInnerElement >> nodeContainersDetect: aBlock [

	^ self explicitRequirement 
]

{ #category : #'t - list inner element' }
TToListInnerElement >> nodeContainersDo: aBlock [

	^ self explicitRequirement 
]

{ #category : #'t - list inner element' }
TToListInnerElement >> nodeContainersReject: aBlock [

	^ self subclassResponsibility 
]

{ #category : #'t - list inner element' }
TToListInnerElement >> nodeContainersSelect: aBlock [

	^ self explicitRequirement 
]

{ #category : #'t - list inner element' }
TToListInnerElement >> nodeContainersWithIndexDo: aBlock [

	^ self explicitRequirement 
]

{ #category : #'t - list inner element' }
TToListInnerElement >> nodeGroupsSatisfying: aBlock [
	" return an array of collection. Each collection contains a list of adjacent selected nodes "

	^ Array streamContents: [ :stream |
		  | g |
		  g := OrderedCollection new.
		  self partlyVisibleNodesDo: [ :container |
			  (aBlock value: container)
				  ifTrue: [ g add: container ]
				  ifFalse: [
					  g ifNotEmpty: [
						  stream nextPut: g.
						  g := OrderedCollection new ] ] ].
		  g ifNotEmpty: [ stream nextPut: g ] ]
]

{ #category : #'t - list inner element' }
TToListInnerElement >> notifyChildAttached: anElement [
	"Notify all event handlers that element (a node) is attached "

	self dispatchEvent: (BlInfiniteElementAttachedEvent element: anElement)
]

{ #category : #'t - list inner element' }
TToListInnerElement >> notifyChildDetached: anElement [
	"Notify all event handlers that element ( a node) is detached "

	self dispatchEvent: (BlInfiniteElementDetachedEvent element: anElement)
]

{ #category : #'t - list inner element' }
TToListInnerElement >> partlyVisibleNodesDo: aBlock [

	^ self explicitRequirement 
]

{ #category : #'t - list inner element' }
TToListInnerElement >> postponeAction: aValuable for: aTarget [

	self dataSourceManager postponeAction: aValuable for: aTarget.
	" ensure a layout here to trigger the action running"
	self requestLayout
]

{ #category : #'t - list inner element' }
TToListInnerElement >> selectableNodeContainingGlobalPosition: aPoint [

	self nodeContainersDo: [ :container |
		((container containsGlobalPoint: aPoint) and: [ container holder isSelectable ])
			ifTrue: [ ^ container ] ].
	^ nil
]

{ #category : #'t - list inner element' }
TToListInnerElement >> withRowNumbers: aBoolean [


]
