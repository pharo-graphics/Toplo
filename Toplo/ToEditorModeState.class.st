Class {
	#name : #ToEditorModeState,
	#superclass : #BlElementState,
	#instVars : [
		'mode'
	],
	#category : #'Toplo-Editor-Model'
}

{ #category : #'instance creation' }
ToEditorModeState class >> editable [
	^ self new mode: BrTextEditorEditableMode
]

{ #category : #'instance creation' }
ToEditorModeState class >> mode: aTextEditorModeClass [
	^ self new mode: aTextEditorModeClass
]

{ #category : #'instance creation' }
ToEditorModeState class >> readOnly [
	^ self readOnlyWithSelection or: self readOnlyWithoutSelection
]

{ #category : #'instance creation' }
ToEditorModeState class >> readOnlyWithSelection [
	^ self new mode: BrTextEditorReadonlyWithSelectionMode 
]

{ #category : #'instance creation' }
ToEditorModeState class >> readOnlyWithoutSelection [
	^ self new mode: BrTextEditorReadonlyWithoutSelectionMode
]

{ #category : #comparing }
ToEditorModeState >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ mode = anObject mode
]

{ #category : #comparing }
ToEditorModeState >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ mode hash
]

{ #category : #accessing }
ToEditorModeState >> mode [
	<return: #Class>

	^ mode
]

{ #category : #accessing }
ToEditorModeState >> mode: aModeClass [
	mode := aModeClass
]

{ #category : #accessing }
ToEditorModeState >> priority [
	^ UserPriority
]

{ #category : #accessing }
ToEditorModeState >> type [
	"Return an object used to compare two states when adding to the collection of states in order to prevent
	elements from having duplicated states"
	<return: #Object>

	^ self class
]
