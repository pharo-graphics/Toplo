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

	| textField |
	" The textField is added whatever the mode to simplify node adding.
	In case of read-only mode, the textfield is set as read-only by the mode "
	textField := self newTextField.
	anElement addChild: textField.

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
ToSelectMode >> newTextField [ 

	| textField |
	textField := ToSelectTextField new
		             select: select;
		             id: #textField;
		             yourself.
	^ textField
]

{ #category : #'api - hooks' }
ToSelectMode >> onInstalledIn: aSelect [

	select := aSelect.

]

{ #category : #'api - hooks' }
ToSelectMode >> onUninstalledIn: aSelect [

	select := nil
]

{ #category : #'accessing selection' }
ToSelectMode >> selectIndex: anIndex [

	self subclassResponsibility 
]
