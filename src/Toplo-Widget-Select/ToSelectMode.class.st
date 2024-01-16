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

]

{ #category : #'accessing selection' }
ToSelectMode >> deselectIndex: anIndex [

	self subclassResponsibility 
]

{ #category : #testing }
ToSelectMode >> isFiltrableMode [

	^ false
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
