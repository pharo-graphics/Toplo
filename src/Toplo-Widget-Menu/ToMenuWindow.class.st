Class {
	#name : #ToMenuWindow,
	#superclass : #ToAnchoredWindow,
	#instVars : [
		'openedSubmenuWindow'
	],
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'api - displaying' }
ToMenuWindow >> close [ 

	openedSubmenuWindow ifNotNil: [ :w | w close ].
	super close
]

{ #category : #accessing }
ToMenuWindow >> defaultElevation [

	^ BlRelativeElevation elevation: (SmallInteger maxVal - 400)
]

{ #category : #testing }
ToMenuWindow >> includes: anElement [

	self = anElement ifTrue: [ ^ true ].
	(self items anySatisfy: [ :e | e includes: anElement ]) ifTrue: [
		^ true ].
	^ false
]

{ #category : #skin }
ToMenuWindow >> installRawStyle [

	super installRawStyle.
	self padding: (BlInsets
			 horizontal: (self tokenValueNamed: #'padding-content-H')
			 vertical: (self tokenValueNamed: #'padding-content-V')).
	(self tokenValueNamed: #'animation-window-opening') value: self.
	self effect: (self tokenValueNamed: #'effect-window')
]

{ #category : #accessing }
ToMenuWindow >> itemHolder [

	^ self element
]

{ #category : #accessing }
ToMenuWindow >> items [

	^ self itemHolder ifNil: [ ^ #(  ) ] ifNotNil: [ :w | w items ]
]

{ #category : #'t - menu window model' }
ToMenuWindow >> menuWindow [

	^ self
]

{ #category : #accessing }
ToMenuWindow >> openedSubmenuWindow [

	^ openedSubmenuWindow
]

{ #category : #accessing }
ToMenuWindow >> openedSubmenuWindow: aWindow [

	openedSubmenuWindow ifNotNil: [ openedSubmenuWindow close ].
	openedSubmenuWindow := aWindow.
]
