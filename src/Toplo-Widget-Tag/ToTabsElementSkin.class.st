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
		e background: Color transparent.
		e border: BlBorder empty.
		e isWrapping ifFalse: [
			selTrack := ToElement new
				            background: (e valueOfTokenNamed: #'border-paint');
				            id: #'selection-track'.
			e itemBar userData at: #'selection-track' put: selTrack.
			selTrack visibility: BlVisibility hidden.
			e itemBar whenLayoutedDoOnce: [
				e isHorizontal
					ifTrue: [
						selTrack
							margin: (BlInsets vertical: 3);
							height: 3;
							width: 0"e  measuredWidth" ]
					ifFalse: [
						selTrack
							margin: (BlInsets horizontal: 3);
							width: 3;
							height: 0"e  measuredHeight" ].
				selTrack whenLayoutedDoOnce: [
					selTrack visibility: BlVisibility visible ] ].
			e addChild: selTrack ] ]
]

{ #category : #'event handling' }
ToTabsElementSkin >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e itemBar userData removeKey: #'selection-track' ifAbsent: [  ].
		(e childWithId: #'selection-track' ifNone: [  ]) ifNotNil: [
			:selTrack | selTrack removeFromParent ] ]
]
