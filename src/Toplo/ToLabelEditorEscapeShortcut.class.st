Class {
	#name : #ToLabelEditorEscapeShortcut,
	#superclass : #AlbEditorShortcut,
	#instVars : [
		'label'
	],
	#category : #'Toplo-Widget-Label'
}

{ #category : #accessing }
ToLabelEditorEscapeShortcut >> description [
	^ 'Escape from text editing'
]

{ #category : #initialization }
ToLabelEditorEscapeShortcut >> initialize [
	super initialize.
	
	combination := BlKeyCombination escape
]

{ #category : #accessing }
ToLabelEditorEscapeShortcut >> label [

	^ label
]

{ #category : #accessing }
ToLabelEditorEscapeShortcut >> label: aLabel [

	label := aLabel
]

{ #category : #accessing }
ToLabelEditorEscapeShortcut >> name [
	^ 'Escape from text editing'
]

{ #category : #evaluation }
ToLabelEditorEscapeShortcut >> performOnEditor: aTextEditor element: aEditorElement dueTo: aShortcutEvent [

	label removeEditor
]
