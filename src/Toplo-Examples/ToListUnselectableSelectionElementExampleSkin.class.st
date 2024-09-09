Class {
	#name : #ToListUnselectableSelectionElementExampleSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Examples-Parts'
}

{ #category : #'event handling' }
ToListUnselectableSelectionElementExampleSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| btn border |
		e positionHook: [ :p :l | p - (l padding left / 2 @ 0) ].
		e sizeHook: [ :p :l | p + ((l padding left / 2) + (l padding right / 2) @ 0) ].
		e layout: BlFrameLayout new.
		e padding: (BlInsets right: 5).
		btn := ToButton new
			       labelText: 'Revert';
			       withNullSkin;
			       yourself.
		btn constraintsDo: [ :c |
			c frame horizontal alignRight.
			c frame vertical alignCenter ].

		btn addEventHandler: (BlEventHandler
				 on: BlClickEvent
				 do: [ :event |
					 event consume.
					 e nodes do: [ :node |
						 node holder listElement unselectableSelecter deselectIndex:
							 node holder position ] ]).

		" consume mouseUp/mouseDown to avoid unwanted opening/closing of the popup list element"
		btn addEventHandler: (BlEventHandler
				 on: BlMouseDownEvent
				 do: [ :event | event consume ]).
		btn addEventHandler: (BlEventHandler
				 on: BlMouseUpEvent
				 do: [ :event | event consume ]).
		btn addEventHandler: (BlEventHandler
				 on: BlMouseEnterEvent
				 do: [ :event | e mouseCursor: Cursor webLink ]).
		btn addEventHandler: (BlEventHandler
				 on: BlMouseLeaveEvent
				 do: [ :event | e mouseCursor: Cursor normal ]).

		e addChild: btn.

		e geometry: (BlRoundedRectangleGeometry cornerRadius:
				 (e valueOfTokenNamed: #'border-radius-SM')).
		border := BlBorderBuilder new
			          paint:
				          (e valueOfTokenNamed: #'border-color-danger-selection');
			          width:
				          (e valueOfTokenNamed: #'border-width-primary-selection');
			          dashArray: (e valueOfTokenNamed: #'dash-array');
			          build.
		e border: border ]
]
