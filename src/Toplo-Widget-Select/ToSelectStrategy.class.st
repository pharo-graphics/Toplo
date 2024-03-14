Class {
	#name : #ToSelectStrategy,
	#superclass : #Object,
	#instVars : [
		'select'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #private }
ToSelectStrategy >> adaptNodeContainerLayout [

	" no effect here "
]

{ #category : #initialization }
ToSelectStrategy >> buildHeaderNodeContainer: anElement [

	self subclassResponsibility 
]

{ #category : #accessing }
ToSelectStrategy >> headerNodeBuilder [

	" see the mutator method  "
	
	^ select headerNodeContainer headerNodeBuilder 
]

{ #category : #accessing }
ToSelectStrategy >> headerNodeBuilder: aValuable [

	" builds a select node element from list data. 
	aValuable take the select node element to build as first argument 
	and the select node holder as second argument"
	
	select headerNodeContainer headerNodeBuilder: aValuable
]

{ #category : #accessing }
ToSelectStrategy >> headerNodeContainerClass [

	^ self subclassResponsibility 
]

{ #category : #private }
ToSelectStrategy >> headerNodeContainerLayout [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToSelectStrategy >> inputTextField [

	^ self textInputElement inputTextField
]

{ #category : #testing }
ToSelectStrategy >> isMultipleSelection [

	^ false
]

{ #category : #initialization }
ToSelectStrategy >> newHeaderNodeContainer [

	^ self headerNodeContainerClass new
		  select: select;
		  id: #headerNodeContainer;
		  layout: self headerNodeContainerLayout;
		  yourself
]

{ #category : #accessing }
ToSelectStrategy >> nodeWrapping: aBoolean [

	" no effect here "
]

{ #category : #'api - hooks' }
ToSelectStrategy >> onInstalledIn: aSelect [

	| nodeContainer |
	select := aSelect.
	" the element that contains nodes + the text field "
	nodeContainer := self newHeaderNodeContainer.
	select headerElement addChild: nodeContainer.
	nodeContainer onInstalledIn: select.
	aSelect listElement selectionMode selectOnMouseDown: true.
	aSelect listElement selectionMode requestFocusOnMouseDown: false.
	self adaptNodeContainerLayout 
]

{ #category : #'api - hooks' }
ToSelectStrategy >> onUninstalledIn: aSelect [

	select headerElement removeChild: select headerNodeContainer.
	select := nil
]

{ #category : #window }
ToSelectStrategy >> onWindowClosed [

	self textInputElement onWindowClosed
]

{ #category : #window }
ToSelectStrategy >> onWindowOpened [

	self textInputElement onWindowOpened
]

{ #category : #'api - hooks' }
ToSelectStrategy >> reInstall [

	| s |
	s := select.
	self onUninstalledIn: s.
	self onInstalledIn: s
]

{ #category : #private }
ToSelectStrategy >> refreshHeaderNodeContainer [

	self subclassResponsibility 
]

{ #category : #accessing }
ToSelectStrategy >> select: aSelect [

	select := aSelect
]

{ #category : #accessing }
ToSelectStrategy >> selectedDataTextField [

	^ self textInputElement selectedDataTextField
]

{ #category : #accessing }
ToSelectStrategy >> textInputElement [

	^ self subclassResponsibility 
]
