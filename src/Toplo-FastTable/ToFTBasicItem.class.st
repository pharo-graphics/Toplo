"
I am an Item of a tree that keep a data and know how to calculate the children of this data for a Fast Tree.

Description
-------------------------------------------------

I am created by a ToFTTreeDataSource or a ToFTItem and I hold a data. I can use a childrenBlock from my dataSource to generate the children of my data.
Myself I use some ToFTBasicItems to creale my children.
I also know how to generate a button for a ToFTTreeDataSource if needed. This button can be use to extand or unextand me.

Public API and Key Messages
-------------------------------------------------

- #expand/#unexpand
        Allow to expand me or unexpand me and update the Tree.. 
   
- #depth
        Return my depth in the tree.

Create me as as my superclass with an object as data.

Example
-------------------------------------------------

(ToFTBasicItem data: Object from: (ToFTTreeDataSource roots: {} children: [ :item | item subclasses ]))
		depth: 2;
		yourself
 
Internal Representation and Key Implementation Points.
-------------------------------------------------

    Instance Variables
	data:		I am an object hold by the item.
	depth:		I am the depth of the Item on the tree.
	isExpanded:		I am a Boolean that remember if I am expanded or not.
	recentlyChanged: 		I am a boolean that return true fi the item was really recently collapsed/expanded. Don't play with me, I am use to update the selection when we collapse/expand an item.
			
I calculate my children with a block that is inside my dataSource. I execute this block with my data, the roots items of the dataSource and my level as arguments.
"
Class {
	#name : #ToFTBasicItem,
	#superclass : #ToFTTreeItem,
	#instVars : [
		'isExpanded',
		'data',
		'depth',
		'recentlyChanged'
	],
	#category : #'Toplo-FastTable-Tree'
}

{ #category : #'expanding-collapsing' }
ToFTBasicItem class >> expandedForm [
	^ self theme treeExpandedForm
]

{ #category : #accessing }
ToFTBasicItem class >> theme [
	^ Smalltalk ui theme
]

{ #category : #'expanding-collapsing' }
ToFTBasicItem class >> unexpandedForm [
	^ self theme treeUnexpandedForm
]

{ #category : #accessing }
ToFTBasicItem >> calculateChildren [
	^ self getChildren
		collect: [ :elem |
			(self class data: elem from: dataSource)
				depth: self depth + 1;
				yourself ]
]

{ #category : #accessing }
ToFTBasicItem >> children [
	"I use a cache because my children can be call often."

	^ children ifNil: [ children := self calculateChildren ]
]

{ #category : #'expanding-collapsing' }
ToFTBasicItem >> collapse [
	"I do not refresh the table. Use collapseAndRefresh for that. I also do not
	ensure that any selected element is visible after collapsing the element.
	If any selected elements are within the childrens of the collapsed element,
	I select the collapsed element."

	self isExpanded ifFalse: [ ^ self ].

	recentlyChanged := true.
	self dataSource
		updateSelectionWithCollectBlock:
			[ :indexOfCurrentSelection :indexOfCollapsedElement |
			| changedBy |
			changedBy := self numberOfVisibleChildren.
			(indexOfCurrentSelection between: indexOfCollapsedElement and: indexOfCollapsedElement + changedBy)
				ifTrue: [ indexOfCollapsedElement ]
				ifFalse: [ indexOfCurrentSelection < indexOfCollapsedElement
						ifTrue: [ indexOfCurrentSelection ]
						ifFalse: [ indexOfCurrentSelection - changedBy ] ] ].
	isExpanded := false
]

{ #category : #'expanding-collapsing' }
ToFTBasicItem >> collapseAll [
	self children do: #collapseAll.
	self collapse
]

{ #category : #'expanding-collapsing' }
ToFTBasicItem >> collapseAndRefresh [

	self dataSource preservingScrollbarPositionDo: [
		self collapse.
		self refreshTable ]
]

{ #category : #button }
ToFTBasicItem >> collpasedButton [
	^ IconicButtonMorph new
		target: self;
		actionSelector: #expandAndRefresh;
		arguments: {};
		labelGraphic: self class unexpandedForm;
		color: Color transparent;
		helpText: 'Expand Item';
		borderWidth: 0
]

{ #category : #accessing }
ToFTBasicItem >> data [
	^ data
]

{ #category : #accessing }
ToFTBasicItem >> data: anObject [
	data := anObject
]

{ #category : #accessing }
ToFTBasicItem >> depth [
	^ depth ifNil: [ depth := 0 ]
]

{ #category : #accessing }
ToFTBasicItem >> depth: anObject [
	depth := anObject
]

{ #category : #'expanding-collapsing' }
ToFTBasicItem >> expand [
	"I do not refresh the table. Use expandAndRefresh for that. I also do not
	ensure that any selected element is visible after expanding the element."

	isExpanded := true.
	recentlyChanged := true.
	self dataSource
		updateSelectionWithCollectBlock: [ :indexOfCurrentSelection :indexOfCollapsedElement |
			indexOfCurrentSelection <= indexOfCollapsedElement
				ifTrue: [ indexOfCurrentSelection ]
				ifFalse: [ indexOfCurrentSelection + self numberOfVisibleChildren ] ]
]

{ #category : #'expanding-collapsing' }
ToFTBasicItem >> expandAll [
	self expand.
	self children do: #expandAll
]

{ #category : #'expanding-collapsing' }
ToFTBasicItem >> expandAllTo: aDepth [
	self expand.
	aDepth > self depth
		ifTrue: [ self children do: [ :each | each expandAllTo: aDepth ] ]
]

{ #category : #'expanding-collapsing' }
ToFTBasicItem >> expandAndRefresh [

	self dataSource preservingScrollbarPositionDo: [
		self expand.
		self refreshTable ]
]

{ #category : #private }
ToFTBasicItem >> expandWithoutChange [
	"I exist because in some rare case it's hard to keep the selection during the expension so I just expand myself don't update the selection :("

	isExpanded := true
]

{ #category : #button }
ToFTBasicItem >> expandedButton [
	^ IconicButtonMorph new
		target: self;
		actionSelector: #collapseAndRefresh;
		arguments: {};
		labelGraphic: self class expandedForm;
		color: Color transparent;
		helpText: 'Unexpand Item';
		borderWidth: 0
]

{ #category : #accessing }
ToFTBasicItem >> expandedChildren [
	self isExpanded ifFalse: [ ^ {} ].
	^ self children flatCollect: #withExpandedChildren
]

{ #category : #button }
ToFTBasicItem >> generateButton [
	^ isExpanded
		ifTrue: [ self expandedButton ]
		ifFalse: [ self collpasedButton ]
]

{ #category : #accessing }
ToFTBasicItem >> getChildren [
	^ dataSource childrenBlock isSymbol
		ifTrue: [ dataSource childrenBlock value: data ]
		ifFalse: [ dataSource childrenBlock cull: data cull: self ]
]

{ #category : #initialization }
ToFTBasicItem >> initialize [
	isExpanded := false.
	recentlyChanged := false
]

{ #category : #accessing }
ToFTBasicItem >> isExpanded [
	^ isExpanded
]

{ #category : #accessing }
ToFTBasicItem >> isRootItem [
	^ self depth = 0
]

{ #category : #printing }
ToFTBasicItem >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $[;
		nextPutAll: (self dataSource toString: data);
		nextPut: $]
]

{ #category : #accessing }
ToFTBasicItem >> recentlyChanged [
	"Since I must be true only if I collapsed recently, I change to false if someone get me."

	^ recentlyChanged
		ifFalse: [ false ]
		ifTrue: [ recentlyChanged := false.
			true ]
]

{ #category : #updating }
ToFTBasicItem >> refreshTable [
	dataSource tableRefresh.
	dataSource table resetFunction
]

{ #category : #updating }
ToFTBasicItem >> updateData [
	children := nil
]

{ #category : #accessing }
ToFTBasicItem >> withExpandedChildren [
	^ {self} , self expandedChildren
]
