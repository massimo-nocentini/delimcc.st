converting
asPresenter
	"<inspectorPresentationOrder: 930 title: 'MicTree'>"

	^ SpTreePresenter new
		  roots: { self };
		  children: [ :t | t children asLinkedList ];
		  display: [ :each |
			  String streamContents: [ :stream | each displayStringOn: stream ] ];
		  yourself