Class {
	#name : #ToSelectMode,
	#superclass : #Object,
	#instVars : [
		'select'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #initialization }
ToSelectMode >> configureMonoSelectNodeContainer: anElement [


]

{ #category : #initialization }
ToSelectMode >> configureMultiSelectNodeContainer: anElement [

	| inputTextField |
	" The textField is added whatever the mode to simplify node adding.
	In case of read-only mode, the textfield is set as read-only by the mode "
	inputTextField := self newInputTextField.
	anElement addChild: inputTextField.

]

{ #category : #'accessing selection' }
ToSelectMode >> deselectIndex: anIndex [

	self subclassResponsibility 
]

{ #category : #testing }
ToSelectMode >> isFiltrableMode [

	^ false
]

{ #category : #'instance creation' }
ToSelectMode >> newInputTextField [ 

	| textField |
	textField := self newTextField
		             id: #inputTextField;
		             yourself.
	^ textField
]

{ #category : #'instance creation' }
ToSelectMode >> newTextField [ 

	| textField |
	textField := ToSelectTextField new
		             select: select;
		             yourself.
	^ textField
]

{ #category : #'api - hooks' }
ToSelectMode >> onInstalledIn: aSelect [

	select := aSelect.

]

{ #category : #'accessing list' }
ToSelectMode >> onListClosed [

]

{ #category : #'accessing list' }
ToSelectMode >> onListOpened [


]

{ #category : #'api - hooks' }
ToSelectMode >> onUninstalledIn: aSelect [

	select := nil
]

{ #category : #'accessing selection' }
ToSelectMode >> selectIndex: anIndex [

	self subclassResponsibility 
]
