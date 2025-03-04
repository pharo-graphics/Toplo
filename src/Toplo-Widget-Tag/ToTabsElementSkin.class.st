Class {
	#name : #ToTabsElementSkin,
	#superclass : #ToItemBarElementSkin,
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #'event handling' }
ToTabsElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| selTrack |
		e clipChildren: true.
		e isWrapping ifFalse: [
			selTrack := ToElement new
				            background: (e valueOfTokenNamed: #'border-paint');
				            id: #'selection-track'.
			selTrack constraintsDo: [ :c | c ignoreByLayout ].
			e itemBar userData at: #'selection-track' put: selTrack.
			e isHorizontal
				ifTrue: [
					selTrack constraintsDo: [ :c |
						c ignored horizontal alignLeft.
						c ignored vertical alignBottom ].
					selTrack height: 2.
					selTrack hMatchParent ]
				ifFalse: [
					selTrack constraintsDo: [ :c |
						c ignored horizontal alignRight.
						c ignored vertical alignTop ].
					selTrack width: 2.
					selTrack vMatchParent ].
			e addChild: selTrack ].
		e background: Color transparent.
		e border: BlBorder empty ]
]

{ #category : #'event handling' }
ToTabsElementSkin >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e itemBar userData removeKey: #'selection-track' ifAbsent: [  ].
		(e childWithId: #'selection-track' ifNone: [  ]) ifNotNil: [
			:selTrack | 
				selTrack removeFromParent ] ]
]
