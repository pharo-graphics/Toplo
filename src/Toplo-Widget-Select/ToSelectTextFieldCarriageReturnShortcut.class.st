Class {
	#name : #ToSelectTextFieldCarriageReturnShortcut,
	#superclass : #AlbEditorShortcut,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #accessing }
ToSelectTextFieldCarriageReturnShortcut >> description [
	^ 'CR in the select text field select the first visible element'
]

{ #category : #initialization }
ToSelectTextFieldCarriageReturnShortcut >> initialize [
	super initialize.
	
	combination := BlKeyCombination return
]

{ #category : #accessing }
ToSelectTextFieldCarriageReturnShortcut >> name [
	^ 'Return'
]

{ #category : #evaluation }
ToSelectTextFieldCarriageReturnShortcut >> performOnEditor: aTextEditor element: anEditorElement dueTo: aShortcutEvent [

	| select |
	select := anEditorElement rootAlbumElement select.
	select listElement dataAccessor ifEmpty: [ ^ self ].
	select listElement selecter selectIndex: 1
]
