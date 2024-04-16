Class {
	#name : #ToSelectHeaderNode,
	#superclass : #ToElement,
	#instVars : [
		'selectHolder',
		'startContainer',
		'middleContainer',
		'endContainer',
		'mouseUpHandler'
	],
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #accessing }
ToSelectHeaderNode >> endContainer [

	^ endContainer
]

{ #category : #initialization }
ToSelectHeaderNode >> initialize [

	super initialize.
	
	self applySkinInstallerOnFirstRequest: true.

	self layout: BlLinearLayout horizontal.

	startContainer := ToElement new
		                  fitContent;
		                  layout: BlLinearLayout horizontal;
		                  yourself.
	middleContainer := ToElement new
		                   hMatchParent;
		                   vFitContent;
		                   layout: BlLinearLayout horizontal;
		                   yourself.
	endContainer := ToElement new
		                fitContent;
		                layout: BlLinearLayout horizontal;
		                yourself.
	self addChildren: {
			startContainer.
			middleContainer.
			endContainer }.
			
	self childrenDo: [ :child |
		child constraintsDo: [ :c | c linear vertical alignCenter ] ].
	self fitContent
]

{ #category : #testing }
ToSelectHeaderNode >> isRemovable [

	^ false
]

{ #category : #accessing }
ToSelectHeaderNode >> middleContainer [

	^ middleContainer
]

{ #category : #'api - hooks' }
ToSelectHeaderNode >> onInstalledIn: aSelect [

	" to avoid unwanted window closing (because of the flow 
	layout that can enlarge the select height when a node is added)"
	mouseUpHandler := BlEventHandler
			 on: BlMouseUpEvent
			 do: [ :event | event consume ].
	self addEventHandler: mouseUpHandler
]

{ #category : #'api - hooks' }
ToSelectHeaderNode >> onUninstalledIn: aSelectHeaderNodeContainer [

	self removeEventHandler: mouseUpHandler.
	mouseUpHandler := nil


]

{ #category : #'private configurating' }
ToSelectHeaderNode >> removeFromSelect [
	" 
	First, try to remove the node by deselecting the corresponding list node in the list (if found). 
	Second, if the data is not one of the actual list element data, remove the data through the select "

	| select originalIndex |
	select := self selectHolder select.
	select listElement dataAccessor withIndexDo: [ :d :localIndex |
		((d = self selectHolder data) ) ifTrue: [
			select listElement selecter deselectIndex: localIndex.
			"'local: ' trace. select listElement selectionModel  deselectedIndexes traceCr."
			^ self ] ].
	originalIndex := select sieve dataPositionIndex at:
		                 self selectHolder data.
	select deselectIndex: originalIndex	
]

{ #category : #accessing }
ToSelectHeaderNode >> selectHolder [

	^ selectHolder 
]

{ #category : #accessing }
ToSelectHeaderNode >> selectHolder: aSelectNodeHolder [

	selectHolder := aSelectNodeHolder
]

{ #category : #accessing }
ToSelectHeaderNode >> startContainer [

	^ startContainer
]
