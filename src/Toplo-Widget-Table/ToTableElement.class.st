"
I am the main entry point to reprensent a Table based on the [ant design](https://ant.design/components/table)
"
Class {
	#name : #ToTableElement,
	#superclass : #ToElement,
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#columns => ObservableSlot',
		'#showHeader',
		'#header',
		'#list'
	],
	#category : #'Toplo-Widget-Table-Core'
}

{ #category : #accessing }
ToTableElement >> columns [

	^ columns
]

{ #category : #accessing }
ToTableElement >> columns: anObject [

	columns := anObject
]

{ #category : #accessing }
ToTableElement >> dataAccessor [
	^ self list dataAccessor
]

{ #category : #initialization }
ToTableElement >> defaultLayout [ 

	" don't use vertical or horizontal to allow vertical centering of children "
	^ BlLinearLayout vertical
]

{ #category : #accessing }
ToTableElement >> header [

	^ header
]

{ #category : #accessing }
ToTableElement >> header: anObject [

	header := anObject
]

{ #category : #initialization }
ToTableElement >> initScrollBar [
	| vscrollBar |
	vscrollBar := BlVerticalScrollbarElement new.
	vscrollBar constraintsDo: [ :c |
		c ignoreByLayout.
		c margin: (BlInsets left: 10).
		c ignored horizontal alignRight.
		c ignored vertical alignBottom ].
	vscrollBar attachTo: self list innerElement.
	self list addChild: vscrollBar 
]

{ #category : #initialization }
ToTableElement >> initialize [

	super initialize.
	self class initializeSlots: self.
	self matchParent.
	list := ToTableListElement new
		        id: #list;
		        yourself.
	header := ToTableHeaderElement new
		          id: #header;
		          yourself.
	self addChildren: {
			header.
			list }.
	self initScrollBar.
	self property: #columns whenChangedDo: [
			list columns: self columns.
			header columns: self columns ]
]

{ #category : #accessing }
ToTableElement >> list [

	^ list
]

{ #category : #accessing }
ToTableElement >> list: anObject [

	list := anObject
]
