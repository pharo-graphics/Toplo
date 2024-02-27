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
		e shortcuts: (self shortcutsToInstallIn: e).
		e installShortcuts.
		e icon: (ToImage inner: (self iconNamed: #bottom)) ]
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
		e uninstallShortcuts.
		e icon: nil ]
]
