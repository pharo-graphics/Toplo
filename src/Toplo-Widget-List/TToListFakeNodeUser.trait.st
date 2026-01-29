Trait {
	#name : #TToListFakeNodeUser,
	#instVars : [
		'fakeNodeContainerWrapper',
		'fakeDataItem',
		'isBuildingFakeNodeContainer'
	],
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #'t - list fake node user' }
TToListFakeNodeUser >> checkFakeNodeContainer [

	self isBuildingFakeNodeContainer ifTrue: [ ^ self ].
	fakeNodeContainerWrapper ifNil: [ ^ self installFakeNodeContainer ].
	self reinstallFakeNodeContainer
]

{ #category : #'t - list fake node user' }
TToListFakeNodeUser >> createFakeNodeContainer [

	| wrapper holder |
	wrapper := ToFakeNodeContainerWrapper new.
	holder := self nodeManager newHolder.
	holder infiniteElement: self innerElement.
	holder fakeDataItem: self fakeDataItem.
	holder bindAtPosition: 0.
	" assigning the holder builds the middleContainer (which is the node of the fake node container) "
	wrapper holder: holder.
	wrapper nodeContainer: self nodeManager newNodeContainer.
	wrapper nodeContainer id: #fakeNodeContainer.
	wrapper nodeContainer holder: holder.
	wrapper node holder: holder.
	wrapper node id: #fakeNode.
	holder setupNodeContainerWith: wrapper.
	" add the fake node (to keep a constant minimum size ).
	Pay attention to add the fake node ** before ** the fake node building "
	[ self nodeManager buildNodeContainer: wrapper nodeContainer ]
		on: Error
		do: [ :error |
				'*** Warning: can''t build the fake node container: ' trace.
				error traceCr ].
	[ self nodeManager buildNode: wrapper node ]
		on: Error
		do: [ :error |
				'*** Warning: can''t build the fake node: ' trace.
				error traceCr ].
	^ wrapper
]

{ #category : #'t - list fake node user' }
TToListFakeNodeUser >> defaultFakeDataItem [

	^ ToLabeledIcon new
		  labelText: 'X';
		  yourself
]

{ #category : #'t - list fake node user' }
TToListFakeNodeUser >> fakeDataItem [

	^ fakeDataItem ifNil: [ fakeDataItem := self defaultFakeDataItem ] 
]

{ #category : #'t - list fake node user' }
TToListFakeNodeUser >> fakeDataItem: anObject [

	anObject = fakeDataItem ifTrue: [ ^ self ].
	fakeDataItem := anObject.
	self checkFakeNodeContainer 
]

{ #category : #'t - list fake node user' }
TToListFakeNodeUser >> fakeNode [

	^ self fakeNodeContainer node
]

{ #category : #'t - list fake node user' }
TToListFakeNodeUser >> fakeNodeContainer [

	^ fakeNodeContainerWrapper ifNotNil: [ :w | w nodeContainer ]
]

{ #category : #'t - list fake node user' }
TToListFakeNodeUser >> fakeNodeContainerWrapper [

	^ fakeNodeContainerWrapper 
]

{ #category : #'t - list fake node user' }
TToListFakeNodeUser >> flagAsBuildingFakeNodeContainerWhile: aBlock [

	isBuildingFakeNodeContainer := true.
	aBlock ensure: [ isBuildingFakeNodeContainer := false ]
]

{ #category : #'t - list fake node user' }
TToListFakeNodeUser >> installFakeNodeContainer [
	" the fake node is added in case of an empty data source to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	fakeNodeContainerWrapper := self newFakeNodeContainer.
	self addChild: fakeNodeContainerWrapper at: 1.
	self requestConfiguration
]

{ #category : #'t - list fake node user' }
TToListFakeNodeUser >> isBuildingFakeNodeContainer [

	^ isBuildingFakeNodeContainer ifNil: [
		  isBuildingFakeNodeContainer := false ]
]

{ #category : #'t - list fake node user' }
TToListFakeNodeUser >> isFakeNodeContainer: aNodeContainer [ 

	^ aNodeContainer = self fakeNodeContainer 
]

{ #category : #'t - list fake node user' }
TToListFakeNodeUser >> newFakeNodeContainer [

	self flagAsBuildingFakeNodeContainerWhile: [
		^ self createFakeNodeContainer ]
]

{ #category : #'t - list fake node user' }
TToListFakeNodeUser >> onInnerElementChanged [

	super onInnerElementChanged.
	self checkFakeNodeContainer
]

{ #category : #'t - list fake node user' }
TToListFakeNodeUser >> refreshFakeNodeContainer [

	| holder |
	[ self nodeManager unbuildNode: fakeNodeContainerWrapper node ]
		on: Error
		do: [ :error |
				'*** Warning: can''t unbuild the fake node: ' trace.
				error traceCr ].
	holder := fakeNodeContainerWrapper holder.
	holder dataItem: self fakeDataItem.
	" add the fake node (to keep a constant minimum size ).
	Pay attention to add the fake node ** before ** the fake node building "
	[ self nodeManager buildNode: fakeNodeContainerWrapper node ]
		on: Error
		do: [ :error |
				'*** Warning: can''t rebuild the fake node: ' trace.
				error traceCr ]
]

{ #category : #'t - list fake node user' }
TToListFakeNodeUser >> refreshFakeNodeContainer: aFakeNodeContainerWrapper [

	| holder |
	[ self unbuildNode: aFakeNodeContainerWrapper node ]
		on: Error
		do: [ :error |
				'*** Warning: can''t unbuild the fake node: ' trace.
				error traceCr ].
	holder := aFakeNodeContainerWrapper holder.
	holder dataItem: holder listElement fakeDataItem.
	" add the fake node (to keep a constant minimum size ).
	Pay attention to add the fake node ** before ** the fake node building "
	[ self buildNode: aFakeNodeContainerWrapper node ]
		on: Error
		do: [ :error |
				'*** Warning: can''t rebuild the fake node: ' trace.
				error traceCr ]
]

{ #category : #'t - list fake node user' }
TToListFakeNodeUser >> reinstallFakeNodeContainer [
	" the fake node is added in case of an empty data source to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	self refreshFakeNodeContainer.
	self requestConfiguration
]

{ #category : #'t - list fake node user' }
TToListFakeNodeUser >> sample [

	^ self fakeDataItem
]

{ #category : #'t - list fake node user' }
TToListFakeNodeUser >> sample: aDataItem [

	self fakeDataItem: aDataItem
]
