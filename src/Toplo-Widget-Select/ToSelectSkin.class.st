Class {
	#name : #ToSelectSkin,
	#superclass : #ToGeneralButtonSkin,
	#instVars : [
		'installedShortcuts',
		'filtrable'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'event handling' }
ToSelectSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal ]
]

{ #category : #'event handling' }
ToSelectSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self installShortcutsIn: e.
		e icon: (ToImage inner: (self iconNamed: #bottom)) ]
]

{ #category : #'accessing - shortcuts' }
ToSelectSkin >> installShortcutsIn: aSelect [

	installedShortcuts := self shortcutsToInstallIn: aSelect.
	filtrable := aSelect isFiltrable.
	filtrable ifTrue: [
		installedShortcuts do: [ :sc |
			aSelect inputTextField addEditorShortcut: sc ].
		^ self ].
	installedShortcuts do: [ :sc | aSelect addShortcut: sc ]
]

{ #category : #'accessing - shortcuts' }
ToSelectSkin >> shortcutsToInstallIn: aSelect [

	| listElement |
	listElement := aSelect listElement.

	^ Array streamContents: [ :stream |
		  stream nextPut: (BlShortcutWithAction new
				   combination: BlKeyCombination builder arrowDown build;
				   action: [ :aShortcutEvent :aShortcut |
					   | idx |
					   idx := listElement secondarySelecter nextSelectableIndex.
					   listElement secondarySelecter scrollToIndex: idx.
					   listElement secondarySelecter selectOnlyIndex: idx.
					   aSelect windowManager currentWindow ifNil: [
							   aSelect popupWindowEvent: aShortcutEvent ] ]).

		  stream nextPut: (BlShortcutWithAction new
				   combination: BlKeyCombination builder arrowUp build;
				   action: [ :aShortcutEvent :aShortcut |
					   | idx |
					   idx := listElement secondarySelecter previousSelectableIndex.
					   listElement secondarySelecter scrollToIndex: idx.
					   listElement secondarySelecter selectOnlyIndex: idx ]).

		  listElement isMultipleSelection ifTrue: [
			  stream nextPut: (BlShortcutWithAction new
					   combination: BlKeyCombination primaryA;
					   action: [ :aShortcutEvent :aShortcut |
						   listElement secondarySelecter selectAll ]).

			  stream nextPut: (BlShortcutWithAction new
					   combination: BlKeyCombination builder shift arrowDown build;
					   action: [ :aShortcutEvent :aShortcut |
						   | idx |
						   idx := listElement secondarySelecter nextDeselectedIndex.
						   listElement secondarySelecter selectIndex: idx.
						   listElement secondarySelecter scrollToIndex: idx ]).

			  stream nextPut: (BlShortcutWithAction new
					   combination: BlKeyCombination builder shift arrowUp build;
					   action: [ :aShortcutEvent :aShortcut |
						   | idx |
						   idx := listElement secondarySelecter previousDeselectedIndex.
						   listElement secondarySelecter selectIndex: idx.
						   listElement secondarySelecter scrollToIndex: idx ]) ] ]
]

{ #category : #'event handling' }
ToSelectSkin >> uninstallLookEvent: anEvent [

	super uninstallLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self uninstallShortcutsIn: e.
		e icon: nil ]
]

{ #category : #'accessing - shortcuts' }
ToSelectSkin >> uninstallShortcutsIn: aSelect [

	filtrable ifTrue: [
		installedShortcuts do: [ :sc |
			aSelect inputTextField removeEditorShortcut: sc ].
		^ self ].
	installedShortcuts do: [ :sc | aSelect removeShortcut: sc ]
]
