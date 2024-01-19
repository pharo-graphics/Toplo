Class {
	#name : #ToSelectMode,
	#superclass : #Object,
	#instVars : [
		'select'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #initialization }
ToSelectMode >> configureMultiSelectNodeContainer: anElement [

	| textInput |
	" The textField is added whatever the mode to simplify node adding.
	In case of read-only mode, the textfield is set as read-only by the mode "
	textInput := ToSelectTextInput new.
	textInput onInstalledIn: select.
	textInput hFitContent.
	anElement addChild: textInput.

]

{ #category : #initialization }
ToSelectMode >> defaultMonoSelectHeaderNodeClass [

	^ ToMonoSelectHeaderNode
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

{ #category : #'api - hooks' }
ToSelectMode >> reInstall [

	| s |
	s := select.
	self onUninstalledIn: s.
	self onInstalledIn: s
]

{ #category : #'accessing selection' }
ToSelectMode >> selectIndex: anIndex [

	self subclassResponsibility 
]
