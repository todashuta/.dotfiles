import type { Entrypoint, Denops } from "jsr:@denops/std@^7.0.0";
import { assert, is } from "jsr:@core/unknownutil@^4.0.0";

import { format } from "npm:date-fns@4";

export const main: Entrypoint = (denops: Denops) => {
  denops.dispatcher = {
    decodeURIComponent(s: unknown) {
      assert(s, is.String);
      return globalThis.decodeURIComponent(s);
    },
    encodeURIComponent(s: unknown) {
      assert(s, is.String);
      return globalThis.encodeURIComponent(s);
    },
    dateIso8601() {
      return format(new Date(), "yyyyMMdd'T'HHmmssXX");
    },
    dateFormat(s: unknown) {
      assert(s, is.String);
      return format(new Date(), s);
    },
  };
};
