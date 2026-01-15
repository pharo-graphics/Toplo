"
A ToOutsideEventFilterTest is a test class for testing the behavior of ToOutsideEventFilter
"
Class {
	#name : #ToOutsideEventFilterTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'main',
		'filter'
	],
	#category : #'Toplo-Tests-Support-EventGenerator'
}

{ #category : #running }
ToOutsideEventFilterTest >> addPane [

	| pane outsidePane |
	pane := ToPane new
		        id: #pane;
		        yourself.
	pane width: 200.
	pane vMatchParent.

	pane
		addEventHandlerOn: ToMouseUpOutsideEvent
		do: [ :evt | evt currentTarget removeFromParent ].
	
	outsidePane := ToPane new
		           id: #outsidePane;
		           yourself.
	outsidePane matchParent.

	filter pushElement: pane.

	main addChild: pane.
	main addChild: outsidePane
]

{ #category : #running }
ToOutsideEventFilterTest >> addPaneAndSubPane [

	| pane subPane outsidePane |
	pane := ToPane new
		        id: #pane;
		        yourself.
	pane width: 200.
	pane vMatchParent.

	pane
		addEventHandlerOn: ToMouseUpOutsideEvent
		do: [ :evt | evt currentTarget removeFromParent ].

	subPane := ToPane new
		           id: #subPane;
		           yourself.
	subPane
		addEventHandlerOn: ToMouseUpOutsideEvent
		do: [ :evt | evt currentTarget removeFromParent ].

	subPane width: 100.
	subPane vMatchParent.
	
	outsidePane := ToPane new
		           id: #outsidePane;
		           yourself.
	outsidePane matchParent.

	filter pushElement: pane.
	filter pushElement: subPane.

	main addChild: pane.
	main addChild: subPane.
	main addChild: outsidePane
]

{ #category : #running }
ToOutsideEventFilterTest >> setUp [

	super setUp.

	main := ToPane horizontal.
	main matchParent.
	space root addChild: main.

	filter := ToOutsideEventFilter new
		          eventsToHandle: { BlMouseUpEvent };
		          yourself.
	space root addEventFilter: filter.

]

{ #category : #running }
ToOutsideEventFilterTest >> testOutsideEventWithOnePane [

	| pane outsidePane outsideEvent |
	self addPane.
	pane := main childWithId: #pane.
	outsidePane := main childWithId: #outsidePane.

	pane addEventHandlerOn: ToMouseUpOutsideEvent do: [ :event | outsideEvent := event ].

	BlSpace simulateClickOn: pane.
	self assert: outsideEvent isNil.
	
	BlSpace simulateClickOn: outsidePane.
	self assert: outsideEvent notNil.
	self assert: outsideEvent currentTarget equals: pane.
	self assert: outsideEvent sourceEvent currentTarget equals: space root.
	self assert: outsideEvent sourceEvent target equals: outsidePane.
	self assert: outsideEvent emitter equals: filter
]

{ #category : #running }
ToOutsideEventFilterTest >> testWithOnePane [

	| pane outsidePane |
	self addPane.
	pane := main childWithId: #pane.
	outsidePane := main childWithId: #outsidePane.

	BlSpace simulateClickOn: pane.
	self assert: pane isAttachedToSceneGraph.
	
	BlSpace simulateClickOn: outsidePane.
	self deny: pane isAttachedToSceneGraph.

	self assert: (space root eventDispatcher filters includes: filter).
	BlSpace simulateClickOn: outsidePane.
	self deny: (space root eventDispatcher filters includes: filter).
	

]

{ #category : #running }
ToOutsideEventFilterTest >> testWithPaneAndSubPaneCheckAll [

	| pane subPane outsidePane |
	self addPaneAndSubPane.
	filter checkTopElementOnly: false.
	pane := main childWithId: #pane.
	subPane := main childWithId: #subPane.
	outsidePane := main childWithId: #outsidePane.

	BlSpace simulateClickOn: pane.
	self assert: pane isAttachedToSceneGraph.
	self assert: subPane isAttachedToSceneGraph.

	BlSpace simulateClickOn: subPane.
	self assert: pane isAttachedToSceneGraph.
	self assert: subPane isAttachedToSceneGraph.
	
	BlSpace simulateClickOn: outsidePane.
	self assert: pane isAttachedToSceneGraph.
	self deny: subPane isAttachedToSceneGraph.

	BlSpace simulateClickOn: outsidePane.
	self deny: pane isAttachedToSceneGraph.
	self deny: subPane isAttachedToSceneGraph.

	self assert: (space root eventDispatcher filters includes: filter).
	BlSpace simulateClickOn: outsidePane.
	self deny: (space root eventDispatcher filters includes: filter).
	

]

{ #category : #running }
ToOutsideEventFilterTest >> testWithPaneAndSubPaneCheckAllClickingOnSpaceRoot [

	| pane subPane outsidePane |
	self addPaneAndSubPane.
	filter checkTopElementOnly: false.
	pane := main childWithId: #pane.
	subPane := main childWithId: #subPane.
	outsidePane := main childWithId: #outsidePane.

	BlSpace simulateClickOn: pane.
	self assert: pane isAttachedToSceneGraph.
	self assert: subPane isAttachedToSceneGraph.

	BlSpace simulateClickOn: subPane.
	self assert: pane isAttachedToSceneGraph.
	self assert: subPane isAttachedToSceneGraph.
	
	BlSpace simulateClickOn: space root.
	self assert: pane isAttachedToSceneGraph.
	self deny: subPane isAttachedToSceneGraph.

	BlSpace simulateClickOn: space root.
	self deny: pane isAttachedToSceneGraph.
	self deny: subPane isAttachedToSceneGraph.

	self assert: (space root eventDispatcher filters includes: filter).
	BlSpace simulateClickOn: space root.
	self deny: (space root eventDispatcher filters includes: filter).
	

]

{ #category : #running }
ToOutsideEventFilterTest >> testWithPaneAndSubPaneCheckTopOnly [

	| pane subPane outsidePane |
	self addPaneAndSubPane.
	pane := main childWithId: #pane.
	subPane := main childWithId: #subPane.
	outsidePane := main childWithId: #outsidePane.

	BlSpace simulateClickOn: pane.
	self assert: pane isAttachedToSceneGraph.
	self deny: subPane isAttachedToSceneGraph.

	BlSpace simulateClickOn: subPane.
	self assert: pane isAttachedToSceneGraph.
	self deny: subPane isAttachedToSceneGraph.
	
	BlSpace simulateClickOn: outsidePane.
	self deny: pane isAttachedToSceneGraph.
	self deny: subPane isAttachedToSceneGraph.

	self assert: (space root eventDispatcher filters includes: filter).
	BlSpace simulateClickOn: outsidePane.
	self deny: (space root eventDispatcher filters includes: filter).
	

]
