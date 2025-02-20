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
		e clipChildren: false.
		e isWrapping ifFalse: [
			selTrack := ToElement new
				            background: (e valueOfTokenNamed: #'border-paint');
				            id: #'selection-track'.
			e itemBar userData at: #'selection-track' put: selTrack.
			e isHorizontal
				ifTrue: [
					selTrack
						margin: (BlInsets vertical: 3);
						height: 3;
						hMatchParent ]
				ifFalse: [
					selTrack
						margin: (BlInsets horizontal: 3);
						width: 3;
						vMatchParent ].
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
