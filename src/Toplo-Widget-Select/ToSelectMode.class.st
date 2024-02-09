Class {
	#name : #ToSelectMode,
	#superclass : #Object,
	#instVars : [
		'select'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #accessing }
ToSelectMode >> data [

	self subclassResponsibility 
]

{ #category : #initialization }
ToSelectMode >> defaultMonoSelectHeaderNodeClass [

	^ ToSingleSelectHeaderNode
]

{ #category : #'accessing selection' }
ToSelectMode >> deselectIndex: anIndex [

	self subclassResponsibility 
]

{ #category : #testing }
ToSelectMode >> isFiltrableMode [

	^ false
]

{ #category : #'accessing selection' }
ToSelectMode >> onClickAtIndex: anIndex [

	self subclassResponsibility 
]

{ #category : #'api - hooks' }
ToSelectMode >> onInstalledIn: aSelect [

	select := aSelect.

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
