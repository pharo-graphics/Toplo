Trait {
	#name : #TToInnerListElement,
	#category : #'Toplo-Widget-List-InnerList'
}

{ #category : #'t - inner list element' }
TToInnerListElement >> disableScrolledEvent [

	self eventDispatcher disableScrolledEvent 
]

{ #category : #'t - inner list element' }
TToInnerListElement >> enableScrolledEvent [

	self eventDispatcher enableScrolledEvent
]

{ #category : #'t - inner list element' }
TToInnerListElement >> findElementHolderForDataSourcePosition: aPosition [
	"Return the holder for the node in the given position of the data set"

	self nodeContainersDo: [ :container |
		| holder |
		holder := container holder.
		holder position = aPosition ifTrue: [ ^ holder ] ].
	^ nil
]

{ #category : #'t - inner list element' }
TToInnerListElement >> nodeContainerAt: anIndex [

	" return the holder for the data at anIndex according to currently viewed data range. 
	Returns nil if anIndex is not currently viewed in the infinite element"
	^ (self findElementHolderForDataSourcePosition: anIndex)
		  ifNotNil: [ :holder | holder itemElement ]
		  ifNil: [  ]
]

{ #category : #'t - inner list element - requirements' }
TToInnerListElement >> nodeContainers [

	^ self shouldBeImplemented  
]

{ #category : #'t - inner list element' }
TToInnerListElement >> nodeContainersDetect: aBlock [

	self nodeContainersDo: [ :container | (aBlock value: container) ifTrue: [ ^ container ] ].
	^ nil
]

{ #category : #'t - inner list element - requirements' }
TToInnerListElement >> nodeContainersDo: aBlock [

	^ self shouldBeImplemented 
]

{ #category : #'t - inner list element' }
TToInnerListElement >> nodeContainersReject: aBlock [

	^ self nodeContainersSelect: [ :container | (aBlock value: container) not ]
]

{ #category : #'t - inner list element' }
TToInnerListElement >> nodeContainersSelect: aBlock [

	^ Array streamContents: [ :stream |
		  self nodeContainersDo: [ :container |
			  (aBlock value: container) ifTrue: [ stream nextPut: container ] ] ]
]

{ #category : #'t - inner list element' }
TToInnerListElement >> nodeContainersWithIndexDo: aBlock [

	| idx |
	idx := 1.
	self nodeContainersDo: [ :container |
			aBlock value: container value: idx.
			idx := idx + 1 ]
]

{ #category : #'t - inner list element' }
TToInnerListElement >> nodeGroupsSatisfying: aBlock [
	" return an array of collection. Each collection contains a list of adjacent selected nodes "

	^ Array new: 10 streamContents: [ :stream |
			  | g |
			  g := Array new: 5 streamContents: [ :subStream |
					       self partlyVisibleNodesDo: [ :container |
							       (aBlock value: container)
								       ifTrue: [ subStream nextPut: container ]
								       ifFalse: [
										       subStream size > 0 ifTrue: [
												       stream nextPut: subStream contents.
												       subStream resetContents ] ] ].
					       subStream size > 0 ifTrue: [
						       stream nextPut: subStream contents ] ] ]
]

{ #category : #'t - inner list element' }
TToInnerListElement >> notifyChildAttached: anElement [
	"Notify all event handlers that element (a node) is attached "

	self dispatchEvent: (BlInfiniteElementAttachedEvent element: anElement)
]

{ #category : #'t - inner list element' }
TToInnerListElement >> notifyChildDetached: anElement [
	"Notify all event handlers that element ( a node) is detached "

	self dispatchEvent: (BlInfiniteElementDetachedEvent element: anElement)
]

{ #category : #'t - inner list element' }
TToInnerListElement >> onAppliedDataSourceFilterCommand: aDataSourceCommand [

	self listElement onAppliedDataSourceFilterCommand: aDataSourceCommand
]

{ #category : #'t - inner list element' }
TToInnerListElement >> onAppliedDataSourceSieveCommand: aDataSourceCommand [

	self listElement onAppliedDataSourceSieveCommand: aDataSourceCommand
]

{ #category : #'t - inner list element - requirements' }
TToInnerListElement >> partlyVisibleNodesDo: aBlock [

	^ self shouldBeImplemented 
]

{ #category : #'t - inner list element' }
TToInnerListElement >> postponeAction: aValuable for: aTarget [

	self dataSourceManager postponeAction: aValuable for: aTarget.
	" ensure a layout here to trigger the action running"
	self requestLayout
]

{ #category : #'t - inner list element' }
TToInnerListElement >> selectableNodeContainingGlobalPosition: aPoint [

	self nodeContainersDo: [ :container |
		((container containsGlobalPoint: aPoint) and: [ container holder isSelectable ])
			ifTrue: [ ^ container ] ].
	^ nil
]

{ #category : #'t - inner list element' }
TToInnerListElement >> withRowNumbers: aBoolean [


]
