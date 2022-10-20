Class {
	#name : #ToLabelEditorCarriageReturnShortcut,
	#superclass : #AlbEditorShortcut,
	#instVars : [
		'label'
	],
	#category : #'Toplo-Widget-Label'
}

{ #category : #initialization }
ToLabelEditorCarriageReturnShortcut >> combination: aCombination [


	combination := aCombination

]

{ #category : #accessing }
ToLabelEditorCarriageReturnShortcut >> description [
	^ 'Accept the edited text'
]

{ #category : #initialization }
ToLabelEditorCarriageReturnShortcut >> initialize [
	super initialize.
	
	combination := BlKeyCombination return
]

{ #category : #accessing }
ToLabelEditorCarriageReturnShortcut >> label [

	^ label
]

{ #category : #accessing }
ToLabelEditorCarriageReturnShortcut >> label: aLabel [

	label := aLabel
]

{ #category : #accessing }
ToLabelEditorCarriageReturnShortcut >> name [
	^ 'Accept edited text'
]

{ #category : #evaluation }
ToLabelEditorCarriageReturnShortcut >> performOnEditor: aTextEditor element: aEditorElement dueTo: aShortcutEvent [

	label text: aEditorElement text.
	label removeEditor
]
