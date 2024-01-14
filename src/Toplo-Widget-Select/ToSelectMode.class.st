Class {
	#name : #ToSelectMode,
	#superclass : #Object,
	#instVars : [
		'select'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #adding }
ToSelectMode >> addDataNode: aNode [

	self subclassResponsibility 
]

{ #category : #'accessing selection' }
ToSelectMode >> deselectIndex: anIndex [

	self subclassResponsibility 
]

{ #category : #initialization }
ToSelectMode >> initializeMultiSelectNodeContainer: anElement [
]

{ #category : #testing }
ToSelectMode >> isEditableMode [

	^ false
]

{ #category : #'api - hooks' }
ToSelectMode >> onInstalledIn: aSelect [

	select := aSelect
]

{ #category : #'api - hooks' }
ToSelectMode >> onUninstalledIn: aSelect [

	select := nil
]

{ #category : #'accessing selection' }
ToSelectMode >> selectIndex: anIndex [

	self subclassResponsibility 
]

{ #category : #'accessing selection' }
ToSelectMode >> selectIndexes: aCollection [

	self subclassResponsibility 
]
